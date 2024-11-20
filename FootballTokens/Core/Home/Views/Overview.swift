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
    
    var body: some View {
        NavigationStack {
            
            // background layer
            ZStack {
                Color.backgroundColor.background.ignoresSafeArea()
                
                // content layer
                VStack {
                    header
                    bestPerforming
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
        HStack {
            Text("Chart example")
                .foregroundStyle(Color.textColor.primary)
                .padding()
        }
    }
    
    private var coinsList: some View {
     
        VStack {
            HStack {
                Text("Overview for")
                Text("Picker")
                
                Spacer()
                
                    SquareButton(image: Image(.filter)) {
                        withAnimation(.spring) {
                        sortButtonPress.toggle()
                        }
                    }
                    .rotationEffect(Angle(degrees: sortButtonPress ? 180 : 0))
            }
            .foregroundStyle(Color.textColor.primary)
            .padding()
            
            ScrollView {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin)
                }
            }
        }
    }
    
    
}
