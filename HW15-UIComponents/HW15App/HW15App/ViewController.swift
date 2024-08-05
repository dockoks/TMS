import UIKit

class ViewController: UIViewController {
    lazy var showAlertButton = UIButton()
    lazy var customSlider = SlideToUnlockView() { [weak self] in
        self?.showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(customSlider)
        layoutSlider()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSlider()
    }
    
    private func layoutSlider() {
        customSlider.frame = CGRect(
            origin: .init(
                x: 20,
                y: 100
            ),
            size: .init(
                width: UIScreen.main.bounds.width-40,
                height: 60
            )
        )
    }
    
    private func showAlert() {
        let alert = CustomAlert(
            title: "Custom Alert",
            message: "Are you impressed with this custom `slide to unlock` view? \nI think it´s pretty cool",
            leftButtonStyle: .secondary("Cancel"),
            rightButtonStyle: .primary("Do something")
        )
        
        alert.addPrimaryAction { print("Primary action") }
        alert.addSecondaryAction { print("Secondary action")}
        
        present(alert, animated: true)
    }
}
