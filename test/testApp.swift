//
//  testApp.swift
//  test
//
//  Created by Alex Colmenero on 11/19/20.
//

import SwiftUI

enum State_ {
    case select
    case city
}

@main
struct testApp: App {
    @ObservedObject var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.state{
            case .select:
                ContentView()
                    .environmentObject(sessionManager)
            case .city:
                CityVieew()
                    .environmentObject(sessionManager)
            }
        }
    }
}

final class SessionManager: ObservableObject {
    @Published var state: State_ = .select
    
    func showSel() {
        state = .select
    }
    func showCity() {
        state = .city
    }
}
