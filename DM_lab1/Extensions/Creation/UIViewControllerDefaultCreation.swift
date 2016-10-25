import UIKit

extension UIViewController {

    static func createWithDefaultIdentifier<T: UIViewController>() -> T where T: Reusable {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: T.reuseIdentifier) as? T {
            return viewController
        } else {
            fatalError("Failed to create view controller: \(T.reuseIdentifier)")
        }
    }

}
