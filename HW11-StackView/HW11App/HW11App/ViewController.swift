import UIKit

enum Operation: String {
    case divide = "÷"
    case multiply = "×"
    case substract = "–"
    case add = "+"
    case equals = "="
    
    init?(rawValue: String) {
        switch rawValue {
        case "÷":
            self = .divide
        case "×":
            self = .multiply
        case "–":
            self = .substract
        case "+":
            self = .add
        case "=":
            self = .equals
        default:
            return nil
        }
    }
}

enum NumberpadButtonType {
    // light buttons
    case c
    case plusOrMinus
    case percent
    // orange buttons
    case operation(Operation)
    // dark buttons
    case number(Int)
    case comma
}

final class ViewController: UIViewController {
    private let spacing: CGFloat = 12
    private let resultLabel: UILabel = UILabel()
    private var currentOperation: Operation?
    private var currentValue: Float = 0
    private var previousValue: Float = 0
    private var userIsTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .label
        setupUI()
    }
    
    private func setupUI() {
        setupResultLabel()
        let verticalSV = UIStackView(arrangedSubviews: [
            resultLabel,
            makeButtonsRow(
                makeNumberpadButton(of: .c),
                makeNumberpadButton(of: .plusOrMinus),
                makeNumberpadButton(of: .percent),
                makeNumberpadButton(of: .operation(.divide))
            ),
            makeButtonsRow(
                makeNumberpadButton(of: .number(7)),
                makeNumberpadButton(of: .number(8)),
                makeNumberpadButton(of: .number(9)),
                makeNumberpadButton(of: .operation(.multiply))
            ),
            makeButtonsRow(
                makeNumberpadButton(of: .number(4)),
                makeNumberpadButton(of: .number(5)),
                makeNumberpadButton(of: .number(6)),
                makeNumberpadButton(of: .operation(.substract))
            ),
            makeButtonsRow(
                makeNumberpadButton(of: .number(1)),
                makeNumberpadButton(of: .number(2)),
                makeNumberpadButton(of: .number(3)),
                makeNumberpadButton(of: .operation(.add))
            ),
            makeLastRow(
                makeNumberpadButton(of: .number(0)),
                makeNumberpadButton(of: .comma),
                makeNumberpadButton(of: .operation(.equals))
            )
        ])
        verticalSV.axis = .vertical
        verticalSV.spacing = spacing
        verticalSV.setCustomSpacing(spacing * 2, after: resultLabel)
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(verticalSV)
        NSLayoutConstraint.activate([
            verticalSV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spacing),
            verticalSV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing),
            verticalSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            verticalSV.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing)
        ])
    }
    
    private func setupResultLabel() {
        resultLabel.text = "0"
        resultLabel.font = .systemFont(ofSize: 72, weight: .light)
        resultLabel.textAlignment = .right
        resultLabel.textColor = .systemBackground
    }
    
    private func makeButtonsRow(_ buttons: UIView...) -> UIView {
        let horizontalSV = UIStackView(arrangedSubviews: buttons)
        horizontalSV.spacing = spacing
        horizontalSV.axis = .horizontal
        horizontalSV.distribution = .fillEqually
        horizontalSV.translatesAutoresizingMaskIntoConstraints = false
        return horizontalSV
    }
    
    private func makeLastRow(_ buttons: UIView...) -> UIView {
        let zeroButton = buttons[0]
        zeroButton.widthAnchor.constraint(equalToConstant: 2 * (UIScreen.main.bounds.width - spacing * 5) / 4 + spacing).isActive = true
        
        let horizontalSV = UIStackView(arrangedSubviews: buttons)
        horizontalSV.spacing = spacing
        horizontalSV.axis = .horizontal
        horizontalSV.translatesAutoresizingMaskIntoConstraints = false
        return horizontalSV
    }
    
    private func makeNumberpadButton(of type: NumberpadButtonType) -> UIButton {
        let button = UIButton()
        let size = (UIScreen.main.bounds.width - spacing * 5) / 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        if case .number(let digit) = type, digit == 0 {
            button.widthAnchor.constraint(equalToConstant: 2 * size + spacing).isActive = true
        } else {
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        button.layer.cornerRadius = size / 2
        setupButtonColors(button: button, of: type)
        setupButtonLabel(button: button, of: type, size: size / 2)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        
        if case .number(let digit) = type {
            button.tag = digit
        }
        
        return button
    }
    
    private func setupButtonColors(button: UIButton, of type: NumberpadButtonType) {
        switch type {
        case .c, .plusOrMinus, .percent:
            button.backgroundColor = .lightGray
            button.setTitleColor(.label, for: .normal)
        case .operation:
            button.backgroundColor = .orange
            button.setTitleColor(.systemBackground, for: .normal)
        case .number(_), .comma:
            button.backgroundColor = .darkGray.withAlphaComponent(0.5)
            button.setTitleColor(.systemBackground, for: .normal)
        }
    }
    
    private func setupButtonLabel(button: UIButton, of type: NumberpadButtonType, size: CGFloat) {
        let enlargedSize = size * 1
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: size, weight: .regular)
        
        switch type {
        case .c:
            button.setTitle("C", for: .normal)
        case .plusOrMinus:
            button.setTitle("±", for: .normal)
        case .percent:
            button.setTitle("%", for: .normal)
        case .operation(let operation):
            button.setTitle(operation.rawValue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: enlargedSize, weight: .medium)
        case .number(let digit):
            button.setTitle("\(digit)", for: .normal)
            if digit == 0 {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
                button.contentHorizontalAlignment = .left
            }
        case .comma:
            button.setTitle(",", for: .normal)
        }
    }
    
    @objc
    private func buttonDidTap(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            if let digit = Int(title) {
                numberButtonDidTap(digit: digit)
            } else if let operation = Operation(rawValue: title) {
                operationButtonDidTap(operation: operation)
            } else if title == "," {
                commaButtonDidTap()
            } else if title == "C" {
                clearButtonDidTap()
            } else if title == "±" {
                plusOrMinusButtonDidTap()
            } else if title == "%" {
                percentButtonDidTap()
            }
        }
    }
    
    private func numberButtonDidTap(digit: Int) {
        if userIsTyping {
            resultLabel.text = resultLabel.text! + "\(digit)"
        } else {
            resultLabel.text = "\(digit)"
            userIsTyping = true
        }
        currentValue = Float(resultLabel.text!) ?? 0
    }
    
    private func operationButtonDidTap(operation: Operation) {
        if currentOperation != nil && userIsTyping {
            calculateResult()
        }
        previousValue = currentValue
        currentOperation = operation
        userIsTyping = false
    }
    
    private func commaButtonDidTap() {
        if userIsTyping {
            if !(resultLabel.text?.contains(".") ?? false) {
                resultLabel.text = resultLabel.text! + "."
            }
        } else {
            resultLabel.text = "0."
            userIsTyping = true
        }
    }
    
    private func clearButtonDidTap() {
        currentValue = 0
        previousValue = 0
        currentOperation = nil
        userIsTyping = false
        resultLabel.text = "0"
    }
    
    private func plusOrMinusButtonDidTap() {
        currentValue = -currentValue
        resultLabel.text = formatResult(currentValue)
    }
    
    private func percentButtonDidTap() {
        currentValue = currentValue / 100
        resultLabel.text = formatResult(currentValue)
    }
    
    private func calculateResult() {
        var result: Float = 0
        
        switch currentOperation {
        case .divide:
            if currentValue == 0 {
                resultLabel.text = "Error"
                clearButtonDidTap()
                return
            }
            result = previousValue / currentValue
        case .multiply:
            result = previousValue * currentValue
        case .substract:
            result = previousValue - currentValue
        case .add:
            result = previousValue + currentValue
        case .equals:
            break
        case .none:
            return
        }
        
        resultLabel.text = formatResult(result)
        currentValue = result
        previousValue = result
        userIsTyping = false
    }
    
    private func formatResult(_ result: Float) -> String {
        if floor(result) == result {
            return String(format: "%.0f", result)
        } else {
            return String(result)
        }
    }
}
