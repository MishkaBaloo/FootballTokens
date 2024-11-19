//
//  TabBarViewModel.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import Foundation

class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: TabBarItems = .overview
    
    public func changeTab(tab: TabBarItems) {
        self.selectedTab = tab
    }
}
