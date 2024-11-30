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
        getCoins(for: .day)
    }
    
    func getCoins(for timePeriod: TimePeriods) {
        guard let url = URL(string: "https://api.coinranking.com/v2/coins?tags=football-club&timePeriod=\(timePeriod.keyword)")
        else { return }
        
        coinsSubscribtions = NetworkingManager.download(url: url)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)

            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedCoins in
                print("API Response: \(returnedCoins)")
                self?.allCoins = returnedCoins.data?.coins ?? []
                self?.coinsSubscribtions?.cancel()
            })
    }
}
    

