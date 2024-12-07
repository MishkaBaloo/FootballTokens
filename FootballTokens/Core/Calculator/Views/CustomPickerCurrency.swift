//
//  CustomPickerCurrency.swift
//  FootballTokens
//
//  Created by Michael on 12/5/24.
//

import SwiftUI

struct CustomPickerCurrency: View {
    
    var anchor: Anchor = .bottom
    var allCurrencies: [CalculatorCurrency] = [.usd, .eur, .gbp]
    var cornerRadius: CGFloat = 10
    @Binding var selectedCurrency: CalculatorCurrency
    @State private var showCurrency: Bool = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                HStack(spacing: 0) {
                    Text(selectedCurrency.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.textColor.primary)
                    
                    Image(.arrowDown)
                        .padding(.leading, 6)
                        .rotationEffect(Angle(degrees: showCurrency ? -180 : 0))
                }
                .frame(width: 88, height: 44)
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
                        index += 1
                        zIndex = index
                        showCurrency.toggle()
                    }
                }
                
                VStack {
                    if showCurrency {
                        CurrencyView()
                    }
                }
                .clipped()
                .zIndex(20)
                .cornerRadius(cornerRadius)
                .shadow(color: Color.black, radius: 10)
            }
        }
        .frame(width: 88, height: 44)
        .zIndex(zIndex)
    }
    
    @ViewBuilder
    func CurrencyView() -> some View {
        VStack(spacing: 0) {
            ForEach(allCurrencies, id: \.self) { currency in
                VStack(spacing: 0) {
                    if currency != allCurrencies.first {
                        Divider()
                            .frame(height: 1)
                            .background(Color.black)
                    }
                    HStack(spacing: 0) {
                        Text(currency.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(selectedCurrency == currency ? Color.supportColor.success : Color.textColor.primary)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.supportColor.success)
                            .opacity(selectedCurrency == currency ? 1 : 0)
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 44)
                    .background(
                        selectedCurrency == currency
                        ? Color.layersColor.layerTwo
                        : Color.layersColor.layerFour
                    )
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCurrency = currency
                            showCurrency = false
                            print("Time period cnahged to: \(currency)")
                        }
                    }
                }
            }
        }
        .clipShape(.rect(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.strokeColor.primary, lineWidth: 1)
        )
        .frame(width: 88)
    }
}
