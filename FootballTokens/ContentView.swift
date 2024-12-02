//
//  ContentView.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var tabBarViewModel: TabBarViewModel = TabBarViewModel()
    @State private var showDetail: Bool = false
    @State private var selectedCoin: CoinModel?
    
    var body: some View {
        NavigationStack {
                TabBarContainerView(selection: $tabBarViewModel.selectedTab) {
                    Overview()
                        .tabBarItem(tab: .overview, selection: $tabBarViewModel.selectedTab)
                    Calculator()
                        .tabBarItem(tab: .calculator, selection: $tabBarViewModel.selectedTab)
                    Settings()
                        .tabBarItem(tab: .settings, selection: $tabBarViewModel.selectedTab)
                }
        }
        .preferredColorScheme(.dark)
        .environmentObject(tabBarViewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(HomeViewModel())
}
