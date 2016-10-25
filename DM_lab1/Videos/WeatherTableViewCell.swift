import UIKit

class WeatherTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var morning: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var night: UILabel!

    @IBOutlet weak var date: UILabel!

    func setData(temperature: Temp, dayIndex: Int) {
        title.text = "Zagreb"

        morning.text = "\(temperature.morningTemperature) F"
        day.text = "\(temperature.dayTemperature) F"
        night.text = "\(temperature.nightTemperature) F"

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"

        date.text =  dateFormater.string(from: Date().addingTimeInterval((60 * 60 * 24) * Double(dayIndex)))
    }
}
