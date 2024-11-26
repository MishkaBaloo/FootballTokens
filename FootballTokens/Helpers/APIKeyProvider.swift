//
//  APIKeyProvider.swift
//  FootballTokens
//
//  Created by Michael on 11/25/24.
//

import Foundation


class APIKeyProvider {
    static var coinRankingAPIKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["CoinRankingAPIKey"] as? String else {
            fatalError("🔑 API Key not found. Make sure Secrets.plist is configured properly.")
        }
        return apiKey
    }
}
