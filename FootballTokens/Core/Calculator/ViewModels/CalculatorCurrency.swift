//
//  CalculatorCurrency.swift
//  FootballTokens
//
//  Created by Michael on 12/4/24.
//

import Foundation

struct CalculatorCurrency: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double

    static let usd = CalculatorCurrency(name: "USD", price: 1.0)
    static let eur = CalculatorCurrency(name: "EUR", price: 0.95)
    static let gbp = CalculatorCurrency(name: "UAH", price: 41.60)
}
