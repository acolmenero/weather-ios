//
//  Weather.swift
//  test
//
//  Created by Alex Colmenero on 11/22/20.
//

import Foundation

extension CurrentWeatherData.Main {
    //Calculate Celcius and Fahrenheit Values
    func getFahrenheit(valueInKelvin: Double?) -> Double {
        if let kelvin = valueInKelvin {
            return ((kelvin - 273.15) * 1.8) + 32
        } else {
            return 0
        }
    }
    
    func getCelsius(valueInKelvin: Double?) -> Double {
        if let kelvin = valueInKelvin {
            return kelvin - 273.15
        } else {
            return 0
        }
    }
    
    var minTempFahrenheit: Double {
        return getFahrenheit(valueInKelvin: self.minTempKelvin)
    }
    var minTempCelcius: Double {
        return getCelsius(valueInKelvin: self.minTempKelvin)
    }
    var maxTempFahrenheit: Double {
        return getFahrenheit(valueInKelvin: self.maxTempKelvin)
    }
    var maxTempCelcius: Double {
        return getCelsius(valueInKelvin: self.maxTempKelvin)
    }
}

struct CurrentWeatherData: Decodable {
    
    let weather: [Weather]?
    let coord: Coordinates?
    let base: String? ///Internal paramenter for station information
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Double?
    let sys: Sys?
    let cityId: Int?
    let cityName: String?
    let statusCode: Int? /// cod - Internal parameter for HTTP Response
    
    struct Weather: Decodable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    struct Coordinates: Decodable {
        let lon: Double?
        let lat: Double?
    }
    
    struct Main: Decodable {
        let tempKelvin: Double?
        var tempFahrenheit: Double {
            return getFahrenheit(valueInKelvin: self.tempKelvin)
        }
        var tempCelcius: Double {
            return getCelsius(valueInKelvin: self.tempKelvin)
        }
        
        let pressure: Int?
        let humidity: Int?
        let minTempKelvin: Double? /// used for large cities
        let maxTempKelvin: Double?
        
        private enum CodingKeys: String, CodingKey {
            case tempKelvin = "temp"
            case pressure
            case humidity
            case minTempKelvin = "temp_min"
            case maxTempKelvin = "temp_max"
        }
    }
    
    struct Wind: Decodable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
    
    struct Clouds: Decodable {
        let all: Int?
    }
    
    struct Sys: Decodable {
        let type: Int?
        let id: Int?
        let message: Double?
        let country: String?
        let sunrise: Double?
        let sunset: Double?
    }
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case coord
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case cityId = "id"
        case cityName = "name"
        case statusCode = "cod"
    }
}

extension CurrentWeatherData {
    var timeOfDataCalculation: Date {
        return Date(timeIntervalSince1970: self.dt!)
    }
}
