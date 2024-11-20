//
//  String.swift
//  FootballTokens
//
//  Created by Michael on 11/19/24.
//

import Foundation

extension String {
    /// Converts a String into a Currency with 2 decimal places
    /// ```
    /// Convert "2.66688039535162" to "$2.67"
    /// ```
    func formatCurrency() -> String {
        guard let value = Double(self) else { return "$0.00" } //Convert to Double
        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency // UAH
//        formatter.currencySymbol = "$" // $ after price
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US") // replace coma with dot
        return formatter.string(from: NSNumber(value: value)) ?? "0.00"
    }
    
    func asMoneySignString() -> String {
        return "$" + formatCurrency()
    }
}

