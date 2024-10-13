import UIKit

final class RouterVIP {
    static func start() -> UIViewController {
        let entity = EntityVIP()
        let interactor = InteractorVIP(presenter: nil, entity: entity)
        let viewController = ViewControllerVIP()
        let presenter = PresenterVIP(view: viewController, interactor: interactor)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
