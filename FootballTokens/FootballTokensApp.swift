//
//  FootballTokensApp.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

@main
struct FootballTokensApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(HomeViewModel())
    }
}
