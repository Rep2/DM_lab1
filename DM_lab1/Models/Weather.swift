import Unbox

struct Weather {
    let cityName: String

    let temperatures: [Temp]
}

extension Weather: Unboxable {
    init(unboxer: Unboxer) {
        cityName = unboxer.unbox(key: "city.name", isKeyPath: true)
        temperatures = unboxer.unbox(key: "list")
    }
}

struct Temp: Unboxable {
    let morningTemperature: Double
    let dayTemperature: Double
    let nightTemperature: Double

    init(unboxer: Unboxer) {
        morningTemperature = unboxer.unbox(key: "temp.morn", isKeyPath: true)
        dayTemperature = unboxer.unbox(key: "temp.day", isKeyPath: true)
        nightTemperature = unboxer.unbox(key: "temp.night", isKeyPath: true)
    }
}

extension Temp: JSONable {}
