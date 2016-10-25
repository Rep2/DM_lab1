import UIKit

extension UIView {
    static func createWithDefaultIdentifier(owner: Any, identifier: String) -> UIView? {
        return Bundle.main.loadNibNamed(identifier, owner: owner, options: nil)?[0] as? UIView
    }
}
