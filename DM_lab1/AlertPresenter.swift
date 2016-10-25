import UIKit
import RxSwift

extension UIViewController {
    func presentAlertWithObservable(title: String, message: String? = nil, buttonTitle: String? = nil) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in

            let alertController: UIAlertController

            alertController = UIAlertController(title:title,
                                                message: message,
                                                preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: buttonTitle ?? "OK", style: .cancel, handler: { (action) in
                observer.onNext(true)
                observer.onCompleted()
            }))

            self.present(alertController, animated:true, completion: nil)

            return Disposables.create()
        }
    }

    func presentAlert(title: String, message: String? = nil, buttonTitle: String? = nil) {
        let alertController: UIAlertController

        alertController = UIAlertController(title:title,
                                            message: message,
                                            preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: buttonTitle ?? "OK", style: .cancel, handler: nil))

        self.present(alertController, animated:true, completion: nil)
    }

    func presentAlertWithCancleAction(title: String, message: String? = nil, buttonTitle: String? = nil) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in

            let alertController: UIAlertController

            alertController = UIAlertController(title:title,
                                                message: message,
                                                preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: buttonTitle ?? "OK", style: .default, handler: { (action) in
                observer.onNext(true)
                observer.onCompleted()
            }))

            alertController.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { (action) in
                observer.onNext(false)
                observer.onCompleted()
            }))

            self.present(alertController, animated:true, completion: nil)

            return Disposables.create()
        }
    }
}
