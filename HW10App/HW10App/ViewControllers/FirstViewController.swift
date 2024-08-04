import UIKit

class FirstViewController: UIViewController {
    var passedString: String?
    var customObject: CustomObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "First VC"

        let button = UIButton(type: .system)
        button.setTitle("Go to Second VC", for: .normal)
        button.addTarget(self, action: #selector(goToSecondController), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
        
        passedString = "Hello from First VC"
        customObject = CustomObject(propertyOne: "Property One", propertyTwo: 2, propertyThree: true)
    }

    @objc func goToSecondController() {
        let secondVC = SecondViewController()
        secondVC.passedString = self.passedString
        secondVC.customObject = self.customObject
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
