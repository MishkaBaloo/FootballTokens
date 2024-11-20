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
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSbscribers()
    }
    
    func addSbscribers() {
        
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
