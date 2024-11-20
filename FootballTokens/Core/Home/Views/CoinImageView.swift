//
//  CoinImageView.swift
//  FootballTokens
//
//  Created by Michael on 11/20/24.
//

import SwiftUI

struct CoinImageView: View {
    
    let coin: CoinModel
    
    var body: some View {
        
        AsyncImage(url: URL(string: coin.iconUrl ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let returnedImage):
                returnedImage
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(.tokenPlaceholder)
                    .font(.headline)
            default:
                Image(.tokenPlaceholder)
                    .font(.headline)
            }
        }
    }
}
 

#Preview {
    CoinImageView(coin: CoinModel.mok)
}
