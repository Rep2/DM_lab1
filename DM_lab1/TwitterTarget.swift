import Alamofire

enum TwitterTarget {
    case timeline(queryString: String, maxId: String?, accessToken: String)
    case user(id: String, accessToken: String)
    case token(key: String, secret: String)
}

extension TwitterTarget: WebTarget {
    static let baseURL = "https://api.twitter.com"

    var url: String {
        return TwitterTarget.baseURL + path
    }

    var path: String {
        switch self {
        case .timeline:
            return "/1.1/search/tweets.json"
        case .user:
            return "/1.1/users/show.json"
        case .token:
            return "/oauth2/token"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .timeline:
            return .get
        case .user:
            return .get
        case .token:
            return .post
        }
    }

    var parameters: [String: AnyObject]? {
        switch self {
        case .timeline(let queryParameter, let maxID, _):
            var params = ["q" : queryParameter.URLEscapedString as AnyObject]
            params["max_id"] = maxID as AnyObject

            return params
        case .user(let id, _):
            return ["user_id" : id as AnyObject]
        case .token:
            return [
                "grant_type" : "client_credentials"  as AnyObject
            ]
        }
    }

    var headers: [String : String]? {
        switch self {
        case .timeline(_, _, let accessToken):
            return ["Authorization" : "Bearer \(accessToken)"]
        case .user(_, let accessToken):
            return ["Authorization" : "Bearer \(accessToken)"]
        case .token(let key, let secret):
            return  ["Authorization" : "Basic \(createAuthorizationString(for: key, secret: secret))"]
        }

    }

    var encoding: URLEncoding {
        return .default
    }

}

private func createAuthorizationString
    (for key: String, secret: String) -> String {
    let authorizationData = (key + ":" + secret).data(using: String.Encoding.utf8)
    return authorizationData!.base64EncodedString(options: .endLineWithLineFeed)
}
