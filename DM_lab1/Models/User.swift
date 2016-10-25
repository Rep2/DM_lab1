import Unbox

struct User {
    let id: Int

    let name: String
    let screenName: String

    let description: String

    let followersCount: Int
    let friendsCount: Int
    let favouritesCount: Int
    let statusesCount: Int

    let avatarURL: String

    let bannerURL: String?

    let backgroundColor: String
}

extension User: Unboxable {

    init(unboxer: Unboxer) {
        id = unboxer.unbox(key: "id")

        name = unboxer.unbox(key: "name")
        screenName = unboxer.unbox(key: "screen_name")
        description = unboxer.unbox(key: "description")

        followersCount = unboxer.unbox(key: "followers_count")
        friendsCount = unboxer.unbox(key: "friends_count")
        favouritesCount = unboxer.unbox(key: "favourites_count")
        statusesCount = unboxer.unbox(key: "statuses_count")

        avatarURL = unboxer.unbox(key: "profile_image_url_https")

        bannerURL = unboxer.unbox(key: "profile_banner_url")

        backgroundColor = unboxer.unbox(key: "profile_background_color")
    }
}

extension User: JSONable {}
