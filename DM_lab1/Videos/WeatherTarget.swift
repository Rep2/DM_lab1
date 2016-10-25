import Foundation
import Alamofire

enum WeatherTarget {
    case daily
}

extension WeatherTarget: WebTarget {
    static let baseURL = "http://api.openweathermap.org/data/2.5/"

    var url: String {
        return WeatherTarget.baseURL + path
    }

    var path: String {
        switch self {
        case .daily:
            return "forecast/daily"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .daily:
            return .get
        }
    }

    var parameters: [String: AnyObject]? {
        switch self {
        case .daily:
            return ["q" : "Zagreb,HR" as AnyObject,
                    "cnt" : "16" as AnyObject,
                    "APPID" : "224932b9b472310aa8c2694b8010808d" as AnyObject]
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var encoding: URLEncoding {
        return .default
    }
}
