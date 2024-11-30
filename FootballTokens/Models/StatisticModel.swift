//
//  StatisticModel.swift
//  FootballTokens
//
//  Created by Michael on 11/27/24.
//

import Foundation

struct StatisticModel: Identifiable, Equatable {
    let id = UUID().uuidString
    let title: String
    let description: String?
    let value: String
    let percentageChange: Double?
    
    init(title: String, description: String?, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.description = description
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
