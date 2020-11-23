//
//  ContentView.swift
//  test
//
//  Created by Alex Colmenero on 11/19/20.
//

import SwiftUI
import Foundation

let APIKEY = "8a8a403ff22ce00c54581359c74a2175"

var currentWeather = [CurrentWeatherData]()
var errorMessage = ""

struct ContentView: View {
    @State private var expanded : Bool = false
    
    let decoder = JSONDecoder()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Please select a location to continue!")
                    .frame(alignment: .center)
                    .padding()
                List {
                    DisclosureGroup(
                        isExpanded: $expanded,
                        content: {
                            CityButton(city: "Los Angeles")
                            CityButton(city: "San Fransisco")
                        },
                        label: {
                            Text("Choose a Location:")
                        })
                            .accentColor(.black)
                            .padding()
                }
                .listStyle(InsetGroupedListStyle())
                .foregroundColor(.black)
            }
        }
    }
    
    func getInfo(isLA: Bool) {
        var request : URL!
        if(isLA) {
            request = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=1705545&APPID=\(APIKEY)")!
        } else {
            request = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=5391959&APPID=\(APIKEY)")!
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            updateResults(data)
            DispatchQueue.main.async {
                currentWeather.forEach {
                    //update the UI
                    print("City: \($0.cityName ?? "City not found")")
                    $0.weather?.forEach{
                        print("Sky: \($0.description ?? "no info") ")
                    }
                    print("Temperature Celcius: \($0.main?.tempCelcius ?? 0)")
                    print("Temperature Fahrenheit: \($0.main?.tempFahrenheit ?? 0)")
                    print("Humidity: \($0.main?.humidity  ?? 0)%")
                    print("Min Temperature: \($0.main?.minTempCelcius ?? 0)")
                    print("Max Temperature: \($0.main?.maxTempCelcius ?? 0)")
                    print("Date of Data Refresh: \($0.timeOfDataCalculation)")
                    print("Sunrise: \($0.sys?.sunriseTime ?? Date(timeIntervalSinceNow: 2020-10-26))")
                    print("Sunset: \($0.sys?.sunsetTime ?? Date(timeIntervalSinceNow: 2020-10-26))")
                }
            }
        }.resume()
    }
    
    func updateResults(_ data: Data) {
        currentWeather.removeAll()
        do {
            let rawFeed = try decoder.decode(CurrentWeatherData.self, from: data)
            print("Status: \(rawFeed.statusCode ?? 0)")
            currentWeather = [rawFeed]
        } catch let decodeError as NSError {
            let errorMessage = "Decoder error: \(decodeError.localizedDescription)"
            print(errorMessage)
            return
        }
    }
    
}

struct CityButton : View {
    let city : String
    
    var body: some View {
        Button(action: {
            if(self.city == "Los Angeles") {
                ContentView().getInfo(isLA: true)
            } else {
                ContentView().getInfo(isLA: false)
            }
        }, label: {
            Text(self.city)
        })
            .padding()
            .edgesIgnoringSafeArea(.all)
    }
}

extension CurrentWeatherData.Sys {
    var sunriseTime: Date {
        return Date(timeIntervalSince1970: self.sunrise!)
    }
    
    var sunsetTime: Date {
        return Date(timeIntervalSince1970: self.sunset!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
