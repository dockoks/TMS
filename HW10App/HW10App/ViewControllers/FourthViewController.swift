import UIKit

class FourthViewController: UIViewController {
    var passedString: String?
    var customObject: CustomObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Fourth VC"

        let button = UIButton(type: .system)
        button.setTitle("Go to Fifth VC", for: .normal)
        button.addTarget(self, action: #selector(goToFifthController), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
    }

    @objc func goToFifthController() {
        
        let universalVC = UniversalViewController()
        let fifthVC = FifthViewController()
        fifthVC.passedString = self.passedString
        fifthVC.customObject = self.customObject
        
        universalVC.viewControllerToPresent = fifthVC
        
        self.navigationController?.pushViewController(universalVC, animated: true)
        universalVC.presentViewController()
    }
}
