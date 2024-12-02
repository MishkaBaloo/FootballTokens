//
//  CoinModel.swift
//  FootballTokens
//
//  Created by Michael on 11/19/24.
//

import Foundation

/*
 URL: https://api.coinranking.com/v2/coins?timePeriod=7d&tags=football-club
 
 https://api.coinranking.com/v2/coin/
 
 JSON Response:
 {
     "status": "success",
     "data": {
         "stats": {
             "total": 25,
             "totalCoins": 45563,
             "totalMarkets": 46301,
             "totalExchanges": 189,
             "totalMarketCap": "965",
             "total24hVolume": "28515974741252"
         },
         "coins": [
             {
                 "uuid": "4Xp8aCpzs",
                 "symbol": "PSG",
                 "name": "Paris Saint-Germain Fan Token",
                 "color": "#000000",
                 "iconUrl": "https://cdn.coinranking.com/Pti_SjG9v/paris-saint-germain.png",
                 "marketCap": "52549558",
                 "price": "2.627477892990776",
                 "listedAt": 1618235052,
                 "tier": 1,
                 "change": "-3.93",
                 "rank": 532,
                 "sparkline": [
                     "2.7126702390437516",
                     "2.6799352683905924",
                     "2.698775725265901",
                     "2.6732273166484983",
                     "2.6536253545511475",
                     "2.6342627344479137",
                     "2.6807282846121914",
                     "2.643486206806817",
                     "2.6660953211015097",
                     "2.69814073451456",
                     "2.67366450539888",
                     "2.6471789001291692",
                     "2.673726727350776",
                     "2.6594320463030203",
                     "2.6556915760115345",
                     "2.6471036090739646",
                     "2.6548453637283584",
                     "2.645739084990082",
                     "2.649253721271983",
                     "2.633000702016189",
                     null
                 ],
                 "lowVolume": false,
                 "coinrankingUrl": "https://coinranking.com/coin/4Xp8aCpzs+parissaint-germainfantoken-psg",
                 "24hVolume": "2561178",
                 "btcPrice": "0.000027825820189481",
                 "contractAddresses": []
             }
 */

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let coins: [CoinModel]?
}

// MARK: - Coin
struct CoinModel: Identifiable, Codable {
    var id: String { return uuid }
    let uuid, symbol, name: String
    let iconUrl: String?
    let marketCap, price: String?
    let change: String?
    let rank: Int?
    let sparkline: [String?]
    let h24Volume: String? 
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case symbol
        case name
        case iconUrl
        case marketCap
        case price
        case change
        case rank
        case sparkline
        case h24Volume = "24hVolume"
    }

    
    static var mok: Self {
        CoinModel(uuid: "4Xp8aCpzs", symbol: "PSG", name: "Paris Saint-Germain Fan Token", iconUrl: "https://cdn.coinranking.com/Pti_SjG9v/paris-saint-germain.png", marketCap: "53337608", price: "2.66688039535162", change: "-1.89", rank: 541, sparkline: [
            "2.7126702390437516",
            "2.6799352683905924",
            "2.698775725265901",
            "2.6732273166484983",
            "2.6536253545511475",
            "2.6342627344479137",
            "2.6807282846121914",
            "2.643486206806817",
            "2.6660953211015097",
            "2.69814073451456",
            "2.67366450539888",
            "2.6471789001291692",
            "2.673726727350776",
            "2.6594320463030203",
            "2.6556915760115345",
            "2.6471036090739646",
            "2.6548453637283584",
            "2.645739084990082",
            "2.649253721271983",
            "2.633000702016189"
        ], h24Volume: "2561178")
    }
    
}

