//
//  CustomPickerCalculator.swift
//  FootballTokens
//
//  Created by Michael on 12/5/24.
//

import SwiftUI

struct CustomPickerCalculator: View {
    
    var allCoins: [CoinModel]
    @Binding var selectedCoin: CoinModel
    var anchor: Anchor = .bottom
    
    @State private var showCoinPicker: Bool = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                HStack(spacing: 0) {
                    Text(selectedCoin.symbol)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.textColor.primary)
                    
                    Image(.arrowDown)
                        .padding(.leading, 8)
                        .rotationEffect(Angle(degrees: showCoinPicker ? -180 : 0))
                }
                .frame(width: 105, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.strokeColor.primary, lineWidth: 1)
                )
                .zIndex(10)
                .background(Color.backgroundColor.background)
                .cornerRadius(10)
                .frame(width: size.width ,height: size.height, alignment: anchor == .top ? .bottom : .top)
                .onTapGesture {
                    withAnimation(.snappy) {
                        showCoinPicker.toggle()
                    }
                }
                
                VStack(spacing: 0) {
                    if showCoinPicker {
                        CoinPickerView()
                    }
                }
                .clipped()
                .zIndex(20)
                .cornerRadius(10)
                .shadow(color: Color.black, radius: 10)
            }
        }
        .frame(width: 105, height: 50)
        .zIndex(zIndex)
    }
    
    
    @ViewBuilder
    func CoinPickerView() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(allCoins) { coin in
                    VStack(spacing: 0) {
                        if coin != allCoins.first {
                            Divider()
                                .frame(height: 1)
                                .background(Color.strokeColor.primary)
                        }
                        
                        HStack(spacing: 0) {
                            Text(coin.symbol)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(selectedCoin.id == coin.id ? Color.supportColor.success : Color.textColor.primary)
                            
                            Spacer()
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(Color.supportColor.success)
                                .opacity(selectedCoin.id == coin.id ? 1 : 0)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 8)
                        .background(
                            selectedCoin.id == coin.id
                            ? Color.layersColor.layerTwo
                            : Color.layersColor.layerFour
                        )
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedCoin = coin
                                showCoinPicker = false
                                print("Selected coin changed to: \(coin.symbol)")
                            }
                        }
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.strokeColor.primary, lineWidth: 1)
        )
        .frame(width: 105, height: 220)
        .transition(.scale(scale: 1.5))
    }
}
