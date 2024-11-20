//
//  CoinRowView.swift
//  FootballTokens
//
//  Created by Michael on 11/19/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                HStack {
                    CoinImageView(coin: coin)
                        .frame(width: 38, height: 38)
                    
                    Text(coin.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.textColor.primary)
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 175, height: 40)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    Text(coin.price.asMoneySignString())
                        .foregroundStyle(Color.textColor.primary)
                        .font(.system(size: 16, weight: .bold))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    HStack(spacing: 0) {
                        Text(coin.change ?? "--")
                            .foregroundColor(((coin.change?.contains("-") ?? true)) ?
                                             Color.supportColor.error : Color.supportColor.success)
                        Image(((coin.change?.contains("-") ?? true) ? .property1TrendDown : .property1TrandUp))
                    }
                    .font(.system(size: 14, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color.layersColor.layerTwo)
            .clipShape(.rect(cornerRadius: 15))
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoinRowView(coin: CoinModel.mok)
}
