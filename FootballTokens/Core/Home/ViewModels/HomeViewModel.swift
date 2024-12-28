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
    @Published var favoriteCoins: [CoinModel] = []
    @Published var bestPerformingCoin: CoinModel?
    
    @Published var chartData: [Double] = []
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private let favoriteDataService = FavoritesDataService.instance
    
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
        
        favoriteDataService.$savedEntities
            .sink { [weak self] returnedFavoriteCoins in
                self?.favoriteCoins = self?.mapAllCoinsToFavoriteCoins(allCoins: self?.allCoins ?? [], entity: returnedFavoriteCoins) ?? []
            }
            .store(in: &cancellables)
    }
    
    private func mapAllCoinsToFavoriteCoins(allCoins: [CoinModel], entity: [FavoritesEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard entity.first(where: {$0.coinID == coin.id}) != nil else {
                    return nil
                }
                return coin
            }
    }
    
    private func updateBestPerformingCoin() {
        if let bestCoin = allCoins
            .filter({ $0.change != nil })
            .max(by: {
                guard let change1 = Double($0.change ?? ""),
                      let change2 = Double($1.change ?? "")
                else { return false }
                return change1 < change2
            }) {
            bestPerformingCoin = bestCoin
            chartData = bestCoin.sparkline.compactMap { Double($0 ?? "") }
        }
    }
    
    func updateCoins(for timePeriod: TimePeriods) {
        coinDataService.getCoins(for: timePeriod) { [weak self] (coins: [CoinModel]) in
            DispatchQueue.main.async {
                self?.allCoins = coins
                self?.updateBestPerformingCoin()
            }
        }
    }
    
    func sortCoins(sort: Sorting, coins: inout [CoinModel]) {
        switch sort {
        case .marketCup: coins.sort { Double($0.marketCap ?? "") ?? 0 > Double($1.marketCap ?? "") ?? 0 }
        case .tradingVolume: coins.sort {Double($0.h24Volume ?? "") ?? 0 > Double($1.h24Volume ?? "") ?? 0}
        case .price: coins.sort {Double($0.price ?? "") ?? 0 > Double($1.price ?? "") ?? 0 }
        case .priceReversed: coins.sort { Double($0.price ?? "") ?? 0 < Double($1.price ?? "") ?? 0 }
        case .changeReversed: coins.sort { Double($0.change ?? "0") ?? 0 < Double($1.change ?? "0") ?? 0 }
        case .change: coins.sort { Double($0.change ?? "0") ?? 0 > Double($1.change ?? "0") ?? 0 }
        }
    }
}
