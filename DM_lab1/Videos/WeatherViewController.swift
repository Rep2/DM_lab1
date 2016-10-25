import UIKit
import RxSwift

class WeatherViewController: UITableViewController, Reusable {

    var weather: Weather?

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        (WebGateway()
            .getResource(WeatherTarget.daily) as Observable<Weather>)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { weather in
                    self.weather = weather


                    do {
                        for temperature in weather.temperatures {
                            try CouchbaseGateway.instance.document.putProperties(temperature.toJSON())
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
        return weather?.temperatures.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? WeatherTableViewCell {
            cell.setData(temperature: weather!.temperatures[indexPath.row], dayIndex: indexPath.row)
        }

        return cell
    }

}
