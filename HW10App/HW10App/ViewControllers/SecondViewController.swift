import UIKit

class SecondViewController: UIViewController {
    var passedString: String?
    var customObject: CustomObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Second VC"

        let button = UIButton(type: .system)
        button.setTitle("Go to Third VC", for: .normal)
        button.addTarget(self, action: #selector(goToThirdController), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
    }

    @objc func goToThirdController() {
        let thirdVC = ThirdViewController()
        thirdVC.passedString = self.passedString
        thirdVC.customObject = self.customObject
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
