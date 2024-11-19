//
//  TabBarItems.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import Foundation
import SwiftUI

enum TabBarItems: String, Identifiable, CaseIterable {
    case overview
    case calculator
    case settings
    
    var id: String { rawValue }
    
    @ViewBuilder func buildView() -> some View {
        switch self {
        case .overview: Overview()
        case .calculator: Favorite()
        case .settings: Settings()
        }
    }
    
    var title: String {
        switch self {
        case .overview: return "Overview"
        case .calculator: return "Calculator"
        case .settings: return "Settings"
        
        }
    }
    
    var defaultIcon: Image {
        switch self {
        case .overview:
            Image(.property1Overview)
        case .calculator:
            Image(.property1Calculator)
        case .settings:
            Image(.property1Settings)
        }
    }
    
    var activeIcon: Image {
        switch self {
        case .overview:
            Image(.propertyOverview1Active)
        case .calculator:
            Image(.propertyCalculator1Active)
        case .settings:
            Image(.propertySetting1Active)
        }
    }
}
