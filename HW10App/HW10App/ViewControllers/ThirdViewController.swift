import UIKit

class ThirdViewController: UIViewController {
    var passedString: String?
    var customObject: CustomObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Third VC"

        let button = UIButton(type: .system)
        button.setTitle("Go to Fourth VC", for: .normal)
        button.addTarget(self, action: #selector(goToFourthController), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
    }

    @objc func goToFourthController() {
        let fourthVC = FourthViewController()
        fourthVC.passedString = self.passedString
        fourthVC.customObject = self.customObject
        self.navigationController?.pushViewController(fourthVC, animated: true)
    }
}


