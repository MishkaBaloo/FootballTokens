//
//  FootballTokensApp.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

@main
struct FootballTokensApp: App {
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    
    var body: some Scene {
        WindowGroup {
                if hasLaunchedBefore {
                    ContentView()
                } else {
                    FirstLaunchView(isFirstLaunch: $hasLaunchedBefore)
                        .transition(.move(edge: .leading))
                }
        }
        .environmentObject(HomeViewModel())
    }
}
