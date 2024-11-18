//
//  Overview.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Overview: View {
    
    @State private var showFavoriteView: Bool = false
    
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
                    Spacer()
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
                Text("Overview for ...")
            }
            
            .padding()
            
            HStack {
                Text("Coins liast example")
            }
        }
    }
    
    
}
