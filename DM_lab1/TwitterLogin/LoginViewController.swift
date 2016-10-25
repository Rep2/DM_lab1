import RxSwift
import TwitterKit

class LoginViewController: UIViewController, Reusable {

    @IBOutlet weak var twitterLoginButton: TWTRLogInButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var wireframe: RootWireframe?

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Twitter session fetch completion
        twitterLoginButton.logInCompletion = { session, error in
            if let session = session {
                self.fetchUser(session: session)
            } else if let error = error {
                self.presentAlert(title: error.localizedDescription)
            } else {
                self.presentAlert(title: "Failed to fetch session")
            }
        }

        TwitterUserLogInInteractor
            .getSession()
            .subscribe(
                onNext: { session in
                    self.fetchUser(session: session)
                }, onError: { error in
                    print(error.localizedDescription)
            }).addDisposableTo(disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        wireframe?.navigationController.isNavigationBarHidden = true
    }

    @IBAction func twitterButtnPressed(_ sender: AnyObject) {
        activityIndicator.startAnimating()
    }

    func fetchUser(session: TWTRAuthSession) {
        TwitterUserLogInInteractor.getUser(id: session.userID)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { user in
                   // self.twitterLoginButton.isHidden = true
                    self.activityIndicator.stopAnimating()

                    if let wireframe = self.wireframe {
                        wireframe.pushWireframe(wireframe: .tab(parentWireframe: wireframe, user: user))
                    }

                    do {
                        try CouchbaseGateway.instance.document.putProperties(user.toJSON())
                    } catch let error {
                        print(error.localizedDescription)
                    }

                }, onError: { error in
                    self.activityIndicator.stopAnimating()

                    self.presentAlert(title: error.localizedDescription)
            }).addDisposableTo(disposeBag)
    }
}
