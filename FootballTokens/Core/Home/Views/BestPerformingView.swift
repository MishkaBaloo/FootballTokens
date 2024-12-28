//
//  BestPerformingView.swift
//  FootballTokens
//
//  Created by Michael on 11/22/24.
//

import SwiftUI

struct BestPerformingView: View {
    
    let coin: CoinModel
    
    var body: some View {
                HStack {
                    VStack {
                        CoinImageView(coin: coin)
                            .frame(width: 45, height: 45)
                    }
                    
                    HStack {
                        VStack(spacing: 0) {
                            Text(coin.symbol)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.textColor.primary)
                                .setFont(.nunitoSansBold, size: 20)
                            Text("Market cap \(coin.marketCap?.asMilMoneySignString() ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .setFont(.nunitoSansRegular, size: 14)
                                .foregroundStyle(Color.textColor.secondary)
                        }
                        .frame(width: 180, height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Text(coin.change ?? "--")
                                    .foregroundColor(Color.supportColor.success)
                                    .setFont(.nunitoSansBold, size: 30)
                                Image(.icon)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            HStack {
                                Text(coin.price?.asMoneySignString() ?? "")
                                    .setFont(.nunitoSansBold, size: 16)
                                    .foregroundStyle(Color.textColor.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .frame(height: 70)
                    }
                }
                .padding(.horizontal)
        }
}

#Preview {
    BestPerformingView(coin: CoinModel.mok)
}

