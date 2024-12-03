//
//  Favorite.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Favorite: View {
    
    @Environment(\.dismiss) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    
    private let favoriteDataService = FavoritesDataService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                //background layer
                Color.backgroundColor.background
                    .ignoresSafeArea()
                
                // content layer
                VStack {
                    header
                    if vm.favoriteCoins.isEmpty {
                        notSavedTokensText
                    } else {
                        favoriteList
                    }
                    Spacer()
                }
                .padding(.top)
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(coin: $selectedCoin)
        }
    }
}

#Preview {
    Favorite()
        .environmentObject(HomeViewModel())
}

//MARK: Extensions

extension Favorite {
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var header: some View {
        HStack {
            SquareButton(
                image: Image(.arrowBack),
                action: {
                    presentationMode.callAsFunction()
                }
            )
            
            Spacer()
            
            Text("Favorite")
                .foregroundStyle(Color.textColor.primary)
                .font(.headline)
                .fontWeight(.heavy)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.backgroundColor.background)
                
            }
        }
        .padding(.horizontal)
    }
    
    private var favoriteList: some View {
        ScrollView {
            ForEach(vm.favoriteCoins) { coin in
                CoinRowView(coin: coin)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var notSavedTokensText: some View {
        HStack {
            Text("No favorites Fan Tokens yet...")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.textColor.secondary)
        }
        .padding(.top, 100)
    }
    
}
