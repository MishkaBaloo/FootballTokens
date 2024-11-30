//
//  Enums.swift
//  FootballTokens
//
//  Created by Michael on 11/20/24.
//

import Foundation

enum TimePeriods: String, CaseIterable {
    
    case hour
    case day
    case week
    case month
    case year
    
    var hours: Int {
        switch self {
        case .day: return 24
        case .week: return 168
        case .month: return 720
        case .year: return 8760
        case .hour: return 1
        }
    }
    
    var keyword: String {
        switch self {
        case .hour: "1h"
        case .day: "24h"
        case .week: "7d"
        case .month: "30d"
        case .year: "1y"
        }
    }
}

enum Sorting: String, CaseIterable {
    
    case marketCup
    case tradingVolume
    case price
    case priceReversed
    case changeReversed
    case change
    
    var keyword: String {
        switch self {
        case .marketCup: "Market Cap"
        case .tradingVolume: "Trading Volume"
        case .price: "Highest price"
        case .priceReversed: "Lowest price"
        case .changeReversed: "Worst performing"
        case .change: "Best Performing"
        }
    }
}
