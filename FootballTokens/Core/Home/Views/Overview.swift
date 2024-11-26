//
//  Overview.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Overview: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showFavoriteView: Bool = false
    @State private var sortButtonPress: Bool = false
    @State private var selectionTime: TimePeriods = .day // default value for dateTime
    @State private var selectionFilter: Sorting = .marketCup // defualt value for sorting
    
    var body: some View {
        NavigationStack {
            
            // Background layer
            ZStack {
                Color.backgroundColor.background.ignoresSafeArea()
                
                // Content layer
                VStack {
                    header
                    bestPerforming
                    sorting
                    coinsList
                }
            }
            .navigationDestination(isPresented: $showFavoriteView) {
                Favorite()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Overview()
        .preferredColorScheme(.dark)
        .environmentObject(HomeViewModel())
}

// MARK: Extensions

extension Overview {
    
    private var header: some View {
        HStack {
            Text("Best performing")
                .foregroundStyle(Color.textColor.primary)
                .font(.headline)
                .fontWeight(.heavy)
            
            Spacer()
            
            SquareButton(
                image: Image(.favoriteSaved),
                action: {
                    showFavoriteView.toggle()
                }
            )
        }
        .padding(.horizontal)
    }
    
    private var bestPerforming: some View {
        VStack {
            if let coin = vm.bestPerformingCoin {
                BestPerformingView(coin: coin)
                    .onTapGesture {
                        // detail of best perfomance
                    }
            }
            
            if let chart = vm.bestPerformingCoin {
                CustomChartView(coin: chart)
            }
        }
    }
    
    private var sorting: some View {
        HStack {
            Text("Overview for")
                .foregroundStyle(Color.textColor.primary)
                .font(.system(size: 20, weight: .bold))
            
            CustomPickerByTimePeriod(defaultSelection: .day, selection: $selectionTime)
            Spacer()
            CustomPickerByFilter(defaultSelection: .marketCup, selection: $selectionFilter)
            .padding(.horizontal, 4)
        }
        .padding()
        .zIndex(1.0)
    }
    
    private var coinsList: some View {
            ScrollView {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin)
                }
                Spacer(minLength: 100)
            }
            .scrollIndicators(.hidden)
    }
}
