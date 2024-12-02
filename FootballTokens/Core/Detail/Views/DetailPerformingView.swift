//
//  DetailPerformingView.swift
//  FootballTokens
//
//  Created by Michael on 11/29/24.
//

import SwiftUI

struct DetailPerformingView: View {
    
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
                                .font(.system(size: 20, weight: .bold))
                            Text("Market cap \(coin.marketCap?.asMilMoneySignString() ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .thin))
                                .foregroundStyle(Color.textColor.secondary)
                        }
                        .frame(width: 180, height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Text(coin.price?.asMoneySignString() ?? "")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(Color.textColor.primary)
                            }
                            .padding(.top, 8)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            
                           
                            
                            HStack(spacing: 0) {
                                Text(coin.change ?? "--").foregroundColor(((coin.change?.contains("-") ?? true)) ?
                                                                          Color.supportColor.error : Color.supportColor.success)
                                .font(.system(size: 14, weight: .light))
                                Image(((coin.change?.contains("-") ?? true) ? .property1TrendDown : .property1TrandUp))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 4)
                        }
                        .frame(height: 70)
                    }
                }
                .padding(.horizontal)
        }
}

#Preview {
    DetailPerformingView(coin: CoinModel.mok)
        .preferredColorScheme(.dark)
}
