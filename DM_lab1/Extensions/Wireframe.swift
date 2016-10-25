import UIKit

protocol Wireframe {
    unowned var viewController: UIViewController { get }
    var parentWireframe: Wireframe? { get }

    func pushWireframe(wireframe: RegisteredWireframes)
    func popWireframe()
}

extension Wireframe {

    func pushWireframe(wireframe: RegisteredWireframes) {
        parentWireframe?.pushWireframe(wireframe: wireframe)
    }

    func popWireframe() {
        parentWireframe?.popWireframe()
    }
}
