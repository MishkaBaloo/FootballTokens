//
//  DetailViewModel.swift
//  FootballTokens
//
//  Created by Michael on 11/27/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var supplyInformation: [StatisticModel] = []
    @Published var valueStatistic: [StatisticModel] = []
    @Published var websiteURL: String?
    @Published var coin: CoinModel
    @Published var chartData: [Double] = []
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
            coinDetailService.$coinDetails
                .receive(on: DispatchQueue.main)
                .sink { [weak self] returnedCoinDetails in
                    guard let coinDetails = returnedCoinDetails else { return }
                    let mappedData = self?.mapDataToStatistics(coinDetail: coinDetails)
                    self?.supplyInformation = mappedData?.supply ?? []
                    self?.valueStatistic = mappedData?.value ?? []
                    self?.websiteURL = returnedCoinDetails?.websiteUrl ?? ""
                }
                .store(in: &cancellables)
        }
    
    func updateCoins(for timePeriod: TimePeriods) {
        coinDataService.getCoins(for: timePeriod) { [weak self] (coins: [CoinModel]) in
            DispatchQueue.main.async {
                if let selectedCoin = coins.first(where: { $0.id == self?.coin.id }) {
                    self?.chartData = selectedCoin.sparkline.compactMap { Double($0 ?? "") }
                } else {
                    self?.chartData = []
                }
            }
        }
    }
    
    private func mapDataToStatistics(coinDetail: Coin) -> (supply: [StatisticModel], value: [StatisticModel]) {
        
        let infoArray = createInfoArray(coinDetails: coinDetail)
        let statisticArray = createValueArray(coinDetailModel: coinDetail)
        return (infoArray, statisticArray)
    }
    
    private func createInfoArray(coinDetails: Coin) -> [StatisticModel] {
        
        // supply information
        let circulatingSupply = (coinDetails.supply?.circulating?.formatToMillions() ?? "") + " million ARG"
        let circulatingStat = StatisticModel(title: "Circulating supply", description: nil, value: circulatingSupply)
        
        let totalSupply = (coinDetails.supply?.total?.formatToMillions() ?? "0") + " million ARG"
        let totalStat = StatisticModel(title: "Total supply", description: nil, value: totalSupply)
        
        let maxSupply = (coinDetails.supply?.max?.formatToMillions() ?? "0") + " million ARG"
        let maxStat = StatisticModel(title: "Max supply", description: nil, value: maxSupply)
        
        let infoArray: [StatisticModel] = [
            circulatingStat, totalStat, maxStat
        ]
        return infoArray
    }
    
    private func createValueArray(coinDetailModel: Coin) -> [StatisticModel] {
        
        // value statistic
        let priceToUSD = coinDetailModel.price?.asMoneySignString() ?? ""
        let priceToUSDStat = StatisticModel(title: "Price to USD", description: nil, value: priceToUSD)
        
        let priceToBTC = coinDetailModel.btcPrice.formatCurrencyToBTC() + " BTC"
        let priceToBTCStat = StatisticModel(title: "Price to BTC", description: nil, value: priceToBTC)
        
        let coinRank =  "\(coinDetailModel.rank)"
        let coinRankStat = StatisticModel(title: "Coin rank", description: "A coin’s place on our global ranking (by highest market cap)", value: coinRank)
        
        let the24hVolume = "$ " + (coinDetailModel.the24HVolume?.formatToMillions() ?? "") + " million"
        let the24hVolumeStat = StatisticModel(title: "24h volume", description: "A coin’s place on our global ranking (by highest market cap)", value: the24hVolume)
        
        let marketCap = "$ " + (coinDetailModel.marketCap?.formatToMillions() ?? "") + " million"
        let marketCapStat = StatisticModel(title: "Market cap", description: "The total value of all trades with this coin on exchanges, in the past 24h", value: marketCap)
        
        let volumeMarketCap = ((Double(coinDetailModel.the24HVolume ?? "") ?? 1.0) / (Double(coinDetailModel.marketCap ?? "") ?? 1.0)).asNumberString().formatCurrency()
        let volumeMarketCapStat = StatisticModel(title: "Volume / Market cap", description: "It is a coin’s 24h trading volume divided by its market cap.", value: volumeMarketCap)
        
        let dilutedMarketCap = "$ " + (coinDetailModel.fullyDilutedMarketCap?.formatToMillions() ?? "") + " million"
        let dilutedMarketCapStat = StatisticModel(title: "Fully diluted market cap", description: "It is a coin’s price multiplied by its supply.", value: dilutedMarketCap)
        
        let alltimeHigh = "$ " + (coinDetailModel.allTimeHigh.price?.formatCurrency() ?? "")
        let alltimeHighStat = StatisticModel(title: "All time high", description: nil , value: alltimeHigh)
        

        let statisticArray: [StatisticModel] = [
            priceToUSDStat, priceToBTCStat, coinRankStat, the24hVolumeStat, marketCapStat, volumeMarketCapStat, dilutedMarketCapStat, alltimeHighStat
        ]
        return statisticArray
        
    }
}


