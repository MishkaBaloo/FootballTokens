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
        getCoins(for: .day, sort: .marketCup) // default values
    }
    
    func getCoins(for timePeriod: TimePeriods, sort: Sorting) {

        guard let url = URL(string: "https://api.coinranking.com/v2/coins?timePeriod=\(timePeriod.keyword)&tags=football-club&orderBy=\(sort.keyword)")
//                guard let url = URL(string: "https://api.coinranking.com/v2/coins")
        else { return }
        
        coinsSubscribtions = NetworkingManager.download(url: url)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins.data?.coins ?? []
                self?.coinsSubscribtions?.cancel()
            })
    }
}
    
