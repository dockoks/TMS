import UIKit

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let firstVC = FirstViewController(style: .plain)
        let secondVC = SecondViewController(style: .grouped)
        let thirdVC = ThirdViewController(style: .insetGrouped)
        
        firstVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "1.circle"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "2.circle"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "3.circle"), tag: 2)
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
    }
}

