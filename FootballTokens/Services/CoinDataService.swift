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
    
    var coinsSubscribtions: AnyCancellable?
    
    init() {
        getCoins(for: .month, sort: .marketCup)
    }
    
    func getCoins(for timePeriod: TimePeriods, sort: Sorting) {
        guard let url = URL(string: "https://api.coinranking.com/v2/coins?timePeriod=\(timePeriod.keyword)&tags=football-club&orderBy=\(sort.keyword)")
                
                
        else { return }
        
        coinsSubscribtions = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(String(describing: error))
                }
            } receiveValue: { [weak self] returnedNews in
                self?.allCoins = returnedNews.data?.coins ?? []
                self?.coinsSubscribtions?.cancel()
            }
    }
}
    

