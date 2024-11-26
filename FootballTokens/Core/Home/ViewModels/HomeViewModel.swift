//
//  HomeViewModel.swift
//  FootballTokens
//
//  Created by Michael on 11/20/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var bestPerformingCoin: CoinModel? // just one token
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSbscribers()
    }
    
    func addSbscribers() {
        
        coinDataService.$allCoins
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.updateBestPerformingCoin()
            }
            .store(in: &cancellables)
    }
    
    private func updateBestPerformingCoin() {
        bestPerformingCoin = allCoins
            .filter { $0.change != nil }
            .max(by: {
                guard let change1 = Double($0.change ?? ""),
                      let change2 = Double($1.change ?? "")
                else { return false }
                return change1 < change2
            })
    }
}
