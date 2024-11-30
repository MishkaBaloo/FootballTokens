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
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US") // replace coma with dot
        return formatter.string(from: NSNumber(value: value)) ?? "0.00"
    }
    
    func formatToMillions() -> String {
        guard let value = Double(self) else { return "0.00" }
        
        let millionValue = value / 1_000_000
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        
        if let formattedString = formatter.string(from: NSNumber(value: millionValue)) {
            return formattedString
        } else {
            return "0.00"
        }
    }
    
    func asMoneySignString() -> String {
        return "$" + formatCurrency()
    }
    
    func asMilMoneySignString() -> String {
        return "$ " + formatToMillions() + " m"
    }
    
    func formatCurrencyToBTC() -> String {
        guard let value = Double(self) else { return "0.0" }
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 7
        formatter.minimumFractionDigits = 1
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: value)) ?? "0.0"
    }
}

