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
    case price
    
    var keyword: String {
        switch self {
        case .marketCup: "marketCap"
        case .price: "price"
        }
    }
}
