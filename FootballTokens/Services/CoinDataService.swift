//
//  CoinDataService.swift
//  FootballTokens
//
//  Created by Michael on 11/19/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    private var coinsSubscribtions: AnyCancellable?
    
    init() {
        getCoins(for: .day) // default values
    }
    
    func getCoins(for timePeriod: TimePeriods) {

//        guard let url = URL(string: "https://api.coinranking.com/v2/coins?timePeriod=\(timePeriod.keyword)&tags=football-club&orderBy=marketCap")
        guard let url = URL(string: "https://api.coinranking.com/v2/coins?tags=meme&timePeriod=\(timePeriod.keyword)")
        else { return }
        
        coinsSubscribtions = NetworkingManager.download(url: url)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins.data?.coins ?? []
                self?.coinsSubscribtions?.cancel()
            })
    }
}
    

