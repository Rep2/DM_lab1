import UIKit

class MovieTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

    @IBOutlet weak var language: UILabel!

    @IBOutlet weak var details: UILabel!

    func setData(movie: Movie) {
        title.text = movie.title
        overview.text = movie.overview

        language.text = movie.originalLanguage

        details.text = "Popularity: \(movie.popularity), vote count: \(movie.voteCount)"
    }
}
