import UIKit

class FifthViewController: UIViewController {
    var passedString: String?
    var customObject: CustomObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Fifth VC"

        let label = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        label.textAlignment = .center
        label.text = passedString
        self.view.addSubview(label)

        let propertyOneLabel = UILabel(frame: CGRect(x: 50, y: 200, width: 300, height: 50))
        let propertyTwoLabel = UILabel(frame: CGRect(x: 50, y: 300, width: 300, height: 50))
        let propertyThreeLabel = UILabel(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
        
        propertyOneLabel.textAlignment = .center
        propertyTwoLabel.textAlignment = .center
        propertyThreeLabel.textAlignment = .center
        
        self.view.addSubview(propertyOneLabel)
        self.view.addSubview(propertyTwoLabel)
        self.view.addSubview(propertyThreeLabel)

        if let obj = customObject {
            propertyOneLabel.text = obj.propertyOne
            propertyTwoLabel.text = "\(obj.propertyTwo)"
            propertyThreeLabel.text = "\(obj.propertyThree)"
        }
    }
}

