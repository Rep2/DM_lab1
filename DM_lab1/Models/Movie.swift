import Unbox

struct Movie {
    let title: String
    let overview: String

    let originalLanguage: String

    let popularity: Double
    let voteCount: Int
}

extension Movie: Unboxable {
    init(unboxer: Unboxer) {
        title = unboxer.unbox(key: "title")
        overview = unboxer.unbox(key: "overview")

        originalLanguage = unboxer.unbox(key: "original_language")

        popularity = unboxer.unbox(key: "popularity")
        voteCount = unboxer.unbox(key: "vote_count")
    }
}

extension Movie: JSONable {}

struct Movies: Unboxable {
    let movies: [Movie]

    init(unboxer: Unboxer) {
        movies = unboxer.unbox(key: "results")
    }
}
