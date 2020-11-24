//
//  CityVieew.swift
//  test
//
//  Created by Alex Colmenero on 11/23/20.
//

import SwiftUI

struct CityVieew: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Text("City: \(strings.city ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Sky: \(strings.sky ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Temperature Celcius: \(strings.temp_c ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Temperature Fahrenheit: \(strings.temp_f ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Min Temperature: \(strings.min_temp ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Max Temperature: \(strings.max_temp ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Sunrise: \(strings.sunrise ?? "")")
            .frame(alignment: .center)
            .padding()
        Text("Sunset: \(strings.sunset ?? "")")
            .frame(alignment: .center)
            .padding()
        Button(action:{
            sessionManager.showSel()
        }, label: {Text("Back")})
            .frame(alignment: .center)
            .padding()
    }
}
