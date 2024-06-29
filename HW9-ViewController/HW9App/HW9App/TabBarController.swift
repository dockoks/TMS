import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = FirstViewController(counter: 0)
        let firstNavVC = UINavigationController(rootViewController: firstVC)
        firstNavVC.tabBarItem = UITabBarItem(
            title: "First",
            image: UIImage(systemName: "1.circle.fill"),
            tag: 0
        )
        
        let secondVC = SecondViewController()
        secondVC.tabBarItem = UITabBarItem(
            title: "Second",
            image: UIImage(systemName: "2.circle.fill"),
            tag: 1
        )
        
        viewControllers = [firstNavVC, secondVC]
    }
}
