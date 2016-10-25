import UIKit
import RxSwift

class MoviesViewController: UITableViewController, Reusable {

    var movies = [Movie]()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        (WebGateway()
            .getResource(MovieTarget.topMovies) as Observable<Movies>)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    self.movies = movies.movies

                    do {
                        for movie in movies.movies {
                            try CouchbaseGateway.instance.document.putProperties(movie.toJSON())
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }

                    self.tableView.reloadData()
                }, onError: { error in
                    print(error.localizedDescription)
                }).addDisposableTo(disposeBag)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? MovieTableViewCell {
            cell.setData(movie: movies[indexPath.row])
        }

        return cell
    }

}
