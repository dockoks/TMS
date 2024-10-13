import UIKit

final class TabbarFactory {
    static func assemble() -> UITabBarController {
        let tabBarController = UITabBarController()
        let mvcVC = ViewControllerMVC.instaciate()
        mvcVC.tabBarItem = UITabBarItem(title: "MVC", image: UIImage(systemName: "1.circle"), tag: 0)
        
        let mvvmVC = ViewControllerMVVM.instantiate()
        mvvmVC.tabBarItem = UITabBarItem(title: "MVVM", image: UIImage(systemName: "2.circle"), tag: 1)
        
        let vipVC = RouterVIP.start()
        vipVC.tabBarItem = UITabBarItem(title: "VIP", image: UIImage(systemName: "3.circle"), tag: 2)
    
        tabBarController.tabBar.tintColor = .label
        tabBarController.tabBar.unselectedItemTintColor = .secondaryLabel
        tabBarController.viewControllers = [
            mvcVC,
            mvvmVC,
            vipVC
        ]
        
        return tabBarController
    }
}
