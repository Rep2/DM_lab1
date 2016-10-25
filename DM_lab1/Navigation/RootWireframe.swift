import UIKit

enum RegisteredWireframes {
    case root
    case tab(parentWireframe: Wireframe, user: User)

    var wireframe: Wireframe {
        switch self {
        case .root:
            return RootWireframe()
        case .tab(let parentWireframe, let user):
            return TabWireframe(parentWireframe: parentWireframe, user: user)
        }
    }
}

class RootWireframe: NSObject {

    unowned let viewController: UIViewController
    let navigationController: UINavigationController

    var parentWireframe: Wireframe?

    override init() {
        viewController = UIViewController.createWithDefaultIdentifier() as LoginViewController

        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true

        super.init()

        (viewController as! LoginViewController).wireframe = self
    }
}

extension RootWireframe: Wireframe {

    func pushWireframe(wireframe: RegisteredWireframes) {
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(wireframe.wireframe.viewController, animated: true)
    }

    func popWireframe() {
        navigationController.popViewController(animated: true)
    }

}
