//
//  CoinDetailDataService.swift
//  FootballTokens
//
//  Created by Michael on 11/27/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: Coin? = nil
    let coin: CoinModel
    
    var coinDetailSubscriptions: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
        
     func getCoinsDetails() {
         guard let url = URL(string: "https://api.coinranking.com/v2/coin/\(coin.id)"),
               !coin.id.isEmpty else {
             print("Invalid coin ID")
             return
         }
        
        coinDetailSubscriptions = NetworkingManager.download(url: url)
            .decode(type: WelcomeDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedCoinsDetails in
                self?.coinDetails = returnedCoinsDetails.data?.coin
                self?.coinDetailSubscriptions?.cancel()
            })
     }
    
}
