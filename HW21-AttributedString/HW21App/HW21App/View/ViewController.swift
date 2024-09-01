import UIKit

class ViewController: UIViewController {

    private var textView: TextView!
    private var presenter: TextPresenter!
    private var rangeSlider: UISlider!
    private var colorSegmentedControl: UISegmentedControl!
    private var currentSelectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        let sampleText = NSMutableAttributedString(string: "This is a sample text. Select a range and apply attributes to see them in action.")
        let model = TextModel(text: sampleText, selectedRange: NSMakeRange(0, 0))
        presenter = TextPresenter(model: model, view: textView)

        textView.updateText(sampleText)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTextTap(_:)))
        textView.addGestureRecognizer(tapGesture)
    }

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground

        textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)

        rangeSlider = UISlider()
        rangeSlider.minimumValue = 0
        rangeSlider.maximumValue = 1
        rangeSlider.value = 0
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.addTarget(self, action: #selector(rangeSliderChanged(_:)), for: .valueChanged)
        view.addSubview(rangeSlider)

        colorSegmentedControl = UISegmentedControl(items: ["Red", "Purple", "Blue", "Black"])
        colorSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        colorSegmentedControl.addTarget(self, action: #selector(colorSegmentChanged(_:)), for: .valueChanged)
        view.addSubview(colorSegmentedControl)

        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 200),

            rangeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rangeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rangeSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),

            colorSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            colorSegmentedControl.bottomAnchor.constraint(equalTo: rangeSlider.topAnchor, constant: -20)
        ])

        setupButtons()
    }

    private func setupButtons() {
        let boldButton = AttributeButtonView(icon: UIImage(systemName: "bold") ?? .add) { [weak self] in
            self?.applyBold()
        }
        boldButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boldButton)

        let italicButton = AttributeButtonView(icon: UIImage(systemName: "italic") ?? .add) { [weak self] in
            self?.applyItalic()
        }
        italicButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(italicButton)

        let underlineButton = AttributeButtonView(icon: UIImage(systemName: "underline") ?? .add) { [weak self] in
            self?.applyUnderline()
        }
        underlineButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(underlineButton)

        let strikethroughButton = AttributeButtonView(icon: UIImage(systemName: "strikethrough") ?? .add) { [weak self] in
            self?.applyStrikethrough()
        }
        strikethroughButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(strikethroughButton)

        let customFontButton = AttributeButtonView(icon: UIImage(systemName: "textformat") ?? .add) { [weak self] in
            self?.applyCustomFont()
        }
        customFontButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customFontButton)

        let resetButton = AttributeButtonView(icon: UIImage(systemName: "arrow.counterclockwise") ?? .add) { [weak self] in
            self?.resetText()
        }
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetButton)

        NSLayoutConstraint.activate([
            boldButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boldButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            italicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            italicButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            underlineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            underlineButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            strikethroughButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            strikethroughButton.topAnchor.constraint(equalTo: boldButton.bottomAnchor, constant: 20),

            customFontButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customFontButton.topAnchor.constraint(equalTo: italicButton.bottomAnchor, constant: 20),

            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetButton.topAnchor.constraint(equalTo: underlineButton.bottomAnchor, constant: 20)
        ])
    }

    @objc private func handleTextTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: textView)
        if let range = textView.getSelectedRange(from: location) {
            presenter.setRange(range)
            rangeSlider.value = Float(range.length) / Float(presenter.getTextLength())
        }
    }

    @objc private func rangeSliderChanged(_ sender: UISlider) {
        let selectedLength = Int(sender.value * Float(presenter.getTextLength()))
        let newRange = NSRange(location: presenter.getTextLocation(), length: selectedLength)
        presenter.setRange(newRange)
    }

    @objc private func colorSegmentChanged(_ sender: UISegmentedControl) {
        var color: UIColor
        switch sender.selectedSegmentIndex {
        case 0:
            color = .systemRed
        case 1:
            color = .systemIndigo
        case 2:
            color = .systemTeal
        default:
            color = .label
        }
        presenter.applyAttribute(attribute: .foregroundColor, value: color)
    }

    private func applyBold() {
        presenter.applyAttribute(attribute: .font, value: UIFont.boldSystemFont(ofSize: 16))
    }

    private func applyItalic() {
        presenter.applyAttribute(attribute: .font, value: UIFont.italicSystemFont(ofSize: 16))
    }

    private func applyUnderline() {
        presenter.applyAttribute(attribute: .underlineStyle, value: NSUnderlineStyle.single.rawValue)
    }

    private func applyStrikethrough() {
        presenter.applyAttribute(attribute: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue)
    }

    private func applyCustomFont() {
        if let customFont = UIFont(name: "RobotoMono-Medium", size: 16) {
            presenter.applyAttribute(attribute: .font, value: customFont, shouldToggle: false)
        }
    }

    private func resetText() {
        presenter.resetText()
    }
}
