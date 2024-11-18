//
//  AppConfig.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import Foundation

enum AppConfig {
    
    static let termsOfUseLink = "https://www.google.com/"
    static let privacyPolicyLink = "https://www.google.com/"
    static let shareAppLink = "https://www.google.com/"
  
    static var hoursForComeBackNotification: Double {
        
    #if DEV
        0.5
    #else
        24
    #endif
        
    }
}
