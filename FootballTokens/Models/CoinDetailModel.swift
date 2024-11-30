//
//  CoinDetailModel.swift
//  FootballTokens
//
//  Created by Michael on 11/27/24.
//

import Foundation
/*
 
 URL: https://api.coinranking.com/v2/coin/4Xp8aCpzs - 4Xp8aCpzs that's uuid
 
 JSON Response: 
 
 "status": "success",
 "data": {
     "coin": {
         "uuid": "4Xp8aCpzs",
         "symbol": "PSG",
         "name": "Paris Saint-Germain Fan Token",
         "description": "Paris Saint-Germain Fan Token is a project that engages, transparently connects and moves quickly with fans to create a better experience.",
         "color": "#000000",
         "iconUrl": "https://cdn.coinranking.com/Pti_SjG9v/paris-saint-germain.png",
         "websiteUrl": "https://www.socios.com/paris-saint-germain/",
         "links": [
             {
                 "name": "www.socios.com",
                 "url": "https://www.socios.com/paris-saint-germain/",
                 "type": "website"
             },
             {
                 "name": "sociosdotcom",
                 "url": "https://www.facebook.com/sociosdotcom",
                 "type": "facebook"
             },
             {
                 "name": "accountslogin/?next=/sociosdotcom/",
                 "url": "https://www.instagram.com/accounts/login/?next=/sociosdotcom/",
                 "type": "instagram"
             },
             {
                 "name": "socios-com",
                 "url": "https://www.linkedin.com/company/socios-com/",
                 "type": "linkedin"
             },
             {
                 "name": "socios",
                 "url": "https://medium.com/socios",
                 "type": "medium"
             },
             {
                 "name": "sociosdotcom?is_all=1",
                 "url": "https://weibo.com/sociosdotcom?is_all=1",
                 "type": "sina-weibo"
             },
             {
                 "name": "@socios",
                 "url": "https://twitter.com/socios",
                 "type": "twitter"
             }
         ],
         "supply": {
             "confirmed": true,
             "supplyAt": null,
             "max": "20000000",
             "total": "20000000",
             "circulating": "20000000"
         },
         "numberOfMarkets": 20,
         "numberOfExchanges": 17,
         "24hVolume": "32125388",
         "marketCap": "58819384",
         "fullyDilutedMarketCap": "58819384",
         "price": "2.9409691917291454",
         "btcPrice": "0.000030538903272434",
         "priceAt": 1732730340,
         "change": "-4.97",
         "rank": 540,
         "sparkline": [
             "3.080436312055446",
             "3.2014423953571556",
             "3.177238671016746",
             "3.101452450274235",
             "3.03174837429792",
             "2.9541443470445294",
             "2.9323004348172943",
             "2.891576247700276",
             "2.8752682973178914",
             "2.861340599779206",
             "2.8668188220927706",
             "2.8705474825560118",
             "2.8503598285584983",
             "2.970838568519663",
             "3.071088492593592",
             "2.9414457506596308",
             "2.952803664064314",
             "2.920788501919537",
             "2.9375846261330167",
             "2.9208785635109002",
             "2.9038164567254934",
             "2.9220613751068343",
             "2.9460270963670903",
             null
         ],
         "allTimeHigh": {
             "price": "60.41677765470308",
             "timestamp": 1628553600
         },
         "coinrankingUrl": "https://coinranking.com/coin/4Xp8aCpzs+parissaint-germainfantoken-psg",
         "tier": 1,
         "lowVolume": false,
         "listedAt": 1618235052,
         "hasContent": false,
         "notices": null,
         "contractAddresses": [],
         "tags": [
             "fan-token",
             "football-club",
             "altcoin"
         ]
     }
 }
 
 */

// MARK: - Welcome
struct WelcomeDetail: Codable {
    let status: String
    let data: DataClassDetail?
}

// MARK: - DataClass
struct DataClassDetail: Codable {
    let coin: Coin?
}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name, description: String
    let websiteUrl: String?
    let supply: Supply?
    let the24HVolume, marketCap, fullyDilutedMarketCap, price: String?
    let btcPrice: String
    let change: String?
    let rank: Int
    let sparkline: [String?]
    let allTimeHigh: AllTimeHigh
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, description, websiteUrl, supply
        case the24HVolume = "24hVolume" // fix name of property
        case marketCap, fullyDilutedMarketCap, price, btcPrice, change, rank, sparkline, allTimeHigh
    }
}

// MARK: - AllTimeHigh
struct AllTimeHigh: Codable {
    let price: String?
    let timestamp: Int
}

// MARK: - Supply
struct Supply: Codable {
    let confirmed: Bool
    let max, total, circulating: String?
}
