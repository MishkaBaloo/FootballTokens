//
//  Double.swift
//  FootballTokens
//
//  Created by Michael on 11/22/24.
//

import Foundation

extension Double {
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(self)
        let sign = self < 0 ? "-" : "" 
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            return "\(sign)\(formatted.asNumberString())Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            return "\(sign)\(formatted.asNumberString())Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            return "\(sign)\(formatted.asNumberString())M"
        case 1_000...:
            let formatted = num / 1_000
            return "\(sign)\(formatted.asNumberString())K"
        default:
            return self.asNumberString()
        }
    }
    
    
}
