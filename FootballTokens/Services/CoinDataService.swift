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
    @Published var chartData: [Double] = []
    
    
    init() {
        getCoins(for: .day) { [weak self] coins in
            DispatchQueue.main.async {
                self?.allCoins = coins
                self?.chartData = coins.first?.sparkline.compactMap { Double($0 ?? "") } ?? []
            }
        }
    }
    
    func getCoins(for timePeriod: TimePeriods, completion: @escaping ([CoinModel]) -> Void) {
        guard let url = URL(string: "https://api.coinranking.com/v2/coins?tags=football-club&timePeriod=\(timePeriod.keyword)")
        else { return }
        
        coinsSubscribtions = NetworkingManager.download(url: url)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedCoins in
                let coins = returnedCoins.data?.coins ?? []
                completion(coins)
                self?.coinsSubscribtions?.cancel()
            })
    }
}
    

