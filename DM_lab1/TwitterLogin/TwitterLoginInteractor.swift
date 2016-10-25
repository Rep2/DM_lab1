import TwitterKit
import RxSwift

enum TwitterUserLogInInteractorError: Error {
    case sessionGetFailed
    case logInFailed
}

extension TwitterUserLogInInteractorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .sessionGetFailed:
            return "No Twitter account connected"
        case .logInFailed:
            return "Twitter log in faield"
        }
    }
}

class TwitterUserLogInInteractor {

    static func getSession() -> Observable<TWTRSession> {
        return Observable.create { observer -> Disposable in
            if let session = Twitter.sharedInstance().sessionStore.existingUserSessions().first as? TWTRSession {
                observer.onNext(session)
                observer.onCompleted()
            } else {
                observer.onError(TwitterUserLogInInteractorError.sessionGetFailed)
            }

            return Disposables.create()
        }
    }

    static func logIn() -> Observable<TWTRSession> {
        return Observable.create({ observable -> Disposable in
            Twitter.sharedInstance().logIn { session, error in
                if let session = session {
                    observable.onNext(session)
                    observable.onCompleted()
                } else {
                    observable.onError(TwitterUserLogInInteractorError.logInFailed)
                }
            }

            return Disposables.create()
        })
    }

    static func logOut(session: TWTRSession) {
        Twitter.sharedInstance().sessionStore.logOutUserID(session.userID)
    }

    static func getUser(id: String) -> Observable<User> {
        let authConfig = Twitter.sharedInstance().authConfig

        return WebGateway()
            .getResource(TwitterTarget.token(key: authConfig.consumerKey, secret: authConfig.consumerSecret))
            .flatMap { (token: TwitterAccessToken) -> Observable<User> in
                return WebGateway()
                    .getResource(TwitterTarget.user(id: id, accessToken: token.accessToken))

        }
    }

}
