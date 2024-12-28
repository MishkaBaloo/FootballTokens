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
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .setFont(.nunitoSansBold, size: 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    Text(coin.price?.asMoneySignString() ?? "")
                        .foregroundStyle(Color.textColor.primary)
                        .setFont(.nunitoSansBold, size: 16)
                        .padding(.leading)
                    
                    HStack(spacing: 0) {
                        Text(coin.change ?? "--")
                            .foregroundColor(((coin.change?.contains("-") ?? true)) ?
                                             Color.supportColor.error : Color.supportColor.success)
                        Image(((coin.change?.contains("-") ?? true) ? .property1TrendDown : .property1TrandUp))
                    }
                    .setFont(.nunitoSansRegular, size: 14)
                    .padding(.leading)
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color.layersColor.layerTwo)
            .clipShape(.rect(cornerRadius: 15))
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoinRowView(coin: CoinModel.mok)
}
