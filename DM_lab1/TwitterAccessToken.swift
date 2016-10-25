import Unbox

struct TwitterAccessToken {
    let accessToken: String

    init(accessToken: String = "") {
        self.accessToken = accessToken
    }
}

extension TwitterAccessToken: Unboxable {
    init(unboxer: Unboxer) {
        self.accessToken = unboxer.unbox(key: "access_token")
    }
}

extension TwitterAccessToken: Equatable {}

func == (lhs: TwitterAccessToken, rhs: TwitterAccessToken) -> Bool {
    return lhs.accessToken == rhs.accessToken
}
