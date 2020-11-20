//
//  ContentView.swift
//  test
//
//  Created by Alex Colmenero on 11/19/20.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var expanded : Bool = true
    @State private var results = [Result]()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Group{
                        Color.gray
                        DisclosureGroup(
                            isExpanded: $expanded,
                            content: {
                                VStack {
                                    Button(action: {
                                       getInfo(isLA: true)
                                    }, label: {
                                            Text("Los Angeles")
                                    })
                                    Button(action: {
                                        getInfo(isLA: false)
                                    }, label: {
                                        Text("San Francisco")
                                    })
                                    .padding()
                                    List(results, id: \.trackId) { item in
                                        VStack(alignment: .leading) {
                                            Text(item.trackName)
                                                .font(.headline).foregroundColor(.white)
                                            Text(item.collectionName)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            },
                            label: { Text("Choose a Location:") })
                            .accentColor(.black)
                        .padding()
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 150, alignment: .leading)
                }
            }
        }
    }
    func getInfo(isLA: Bool) {
        var request : URL!
        if(isLA) {
            request = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=1705545&APPID=8a8a403ff22ce00c54581359c74a2175")!
        } else {
            request = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=5391959&APPID=8a8a403ff22ce00c54581359c74a2175")!
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                        print(results)
                    }

                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
    }
}
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct InfoView {
    let main : Text
    let description : Text
    let icon : String
    
    var body: some View {
        Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
