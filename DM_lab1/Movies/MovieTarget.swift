import Alamofire

enum MovieTarget {
    case topMovies
}

extension MovieTarget: WebTarget {
    static let baseURL = "https://api.themoviedb.org/3/discover/"

    var url: String {
        return MovieTarget.baseURL + path
    }

    var path: String {
        switch self {
        case .topMovies:
            return "movie"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .topMovies:
            return .get
        }
    }

    var parameters: [String: AnyObject]? {
        switch self {
        case .topMovies:
            return ["api_key" : "ee038ba50717d825c3275aa0cf6be983" as AnyObject,
                "sort_by" : "popularity.desc" as AnyObject]
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var encoding: URLEncoding {
        return .default
    }
}
