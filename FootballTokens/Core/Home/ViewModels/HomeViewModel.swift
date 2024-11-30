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
    
    func updateCoins(for timePerios: TimePeriods) {
        coinDataService.getCoins(for: timePerios)
    }
    
    func sortCoins(sort: Sorting, coins: inout [CoinModel]) {
        switch sort {
        case .marketCup: coins.sort { Double($0.marketCap ?? "") ?? 0 > Double($1.marketCap ?? "") ?? 0 }
        case .tradingVolume: coins.sort { Double($0.rank ?? 0) < Double($1.rank ?? 0) }
        case .price: coins.sort {Double($0.price ?? "") ?? 0 > Double($1.price ?? "") ?? 0 }
        case .priceReversed: coins.sort { Double($0.price ?? "") ?? 0 < Double($1.price ?? "") ?? 0 }
        case .changeReversed: coins.sort { Double($0.change ?? "0") ?? 0 < Double($1.change ?? "0") ?? 0 }
        case .change: coins.sort { Double($0.change ?? "0") ?? 0 > Double($1.change ?? "0") ?? 0 }
        }
    }
}
