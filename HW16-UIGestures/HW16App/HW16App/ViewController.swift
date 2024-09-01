import UIKit

class ViewController: UIViewController {

    let circleView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        circleView.addGestureRecognizer(tapGesture)
        view.addSubview(circleView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupCircle()
    }

    func setupCircle() {
        let color = getRandomColor()
        circleView.backgroundColor = color
        circleView.layer.cornerRadius = 22
        circleView.transform = CGAffineTransform.identity
        let newX = CGFloat.random(in: 0...(self.view.frame.width - 44))
        let newY = CGFloat.random(in: self.view.safeAreaInsets.top...(self.view.frame.height - 44 - self.view.safeAreaInsets.bottom))
        circleView.frame = CGRect(x: newX, y: newY, width: 44, height: 44)
        circleView.applyShadow(color: color)
        animateCircleAppearance()
    }

    @objc func handleTap() {
        animateCircleDisappearance { [weak self] in
            self?.setupCircle()
        }
    }

    func animateCircleAppearance() {
        UIView.animate(withDuration: 0.15, animations: {
            self.circleView.alpha = 1.0
        })
    }

    func animateCircleDisappearance(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, animations: {
            self.circleView.alpha = 0
            self.circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            completion()
        })
    }

    func getRandomColor() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
