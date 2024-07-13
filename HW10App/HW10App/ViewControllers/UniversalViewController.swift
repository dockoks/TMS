import UIKit

class UniversalViewController: UIViewController {
    var viewControllerToPresent: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Universal VC"
        
        let button = UIButton(type: .system)
        button.setTitle("Present Controller", for: .normal)
        button.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
    }

    @objc func presentViewController() {
        guard let vc = viewControllerToPresent else { return }
        self.navigationController?.present(vc, animated: true)
    }
}
