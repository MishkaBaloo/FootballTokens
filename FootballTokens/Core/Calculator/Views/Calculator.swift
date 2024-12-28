//
//  Calculator.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Calculator: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    
    @State private var fromValue: String = "0"
    @State private var toValue: String = "0.00"
    @State private var selectedCurrency: CalculatorCurrency = .eur
    @State private var selectedCoin: CoinModel = .mok
    @State private var color: Color = Color.textColor.primary
    
    private let CalculatorBauttons: [CalculatorButton] = [
        CalculatorButton(title: "1"), CalculatorButton(title: "2"),
        CalculatorButton(title: "3"), CalculatorButton(title: "4"),
        CalculatorButton(title: "5"),CalculatorButton(title: "6"),
        CalculatorButton(title: "7"), CalculatorButton(title: "8"),
        CalculatorButton(title: "9"), CalculatorButton(title: "."),
        CalculatorButton(title: "0"), CalculatorButton(Image: Image(.delete), isClearButton: true)
    ]
    
    var body: some View {
        ZStack {
            // background layer
            Color.backgroundColor.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                header
                fromSection
                switchButton
                toSection
                dividerSection
                calculatorButtons
                Spacer(minLength: 100)
            }
            .onChange(of: fromValue, { _, _ in
                updateConversion()
            })
            .onChange(of: selectedCurrency) { _, _ in
                updateConversion()
            }
            .padding(.top)
        }
    }
}

#Preview {
    Calculator()
        .environmentObject(HomeViewModel())
}

extension Calculator {
    
    private var header: some View {
        Text("Calculator")
            .foregroundStyle(Color.textColor.primary)
            .setFont(.nunitoSansBold, size: 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal)
    }
    
    private var fromSection: some View {
        HStack {
            VStack {
                Text("From")
                    .setFont(.nunitoSansRegular, size: 14)
                    .foregroundStyle(Color.textColor.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(fromValue)
                    .foregroundStyle(Color.textColor.primary)
                    .setFont(.nunitoSansBold, size: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            CustomPickerCalculator(
                allCoins: homeVM.allCoins,
                selectedCoin: $selectedCoin
            )
            .onChange(of: selectedCoin) { _, _ in
                updateConversion()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.layersColor.layerTwo)
        )
        .padding(.horizontal)
        .padding(.top)
        .zIndex(100)
    }
    
    private var switchButton: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: 44, height: 44)
                .foregroundStyle(Color.layersColor.layerOne)
            
            Image(.arrowUpDown)
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
    
    private var toSection: some View {
        HStack {
            VStack {
                Text("To")
                    .setFont(.nunitoSansRegular, size: 14)
                    .foregroundStyle(Color.textColor.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(toValue)
                    .foregroundStyle(Color.textColor.primary)
                    .setFont(.nunitoSansBold, size: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            CustomPickerCurrency(selectedCurrency: $selectedCurrency)
                .onChange(of: selectedCurrency) { oldValue, newValue in
                    updateConversion()
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.layersColor.layerTwo)
        )
        .padding(.horizontal)
        .zIndex(10)
    }
    
    private var dividerSection: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .padding()
            .foregroundStyle(Color.strokeColor.secondary)
    }
    
    private var calculatorButtons: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns, spacing: 50) {
            ForEach(CalculatorBauttons) { button in
                Button(action: {
                    calculatorBattonPress(button)
                }) {
                    VStack {
                        if let title = button.title {
                            Text(title)
                                .foregroundColor(button.colorText)
                                .setFont(.nunitoSansBold, size: 30)
                        } else if let image = button.Image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(button.colorText)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func calculatorBattonPress(_ button: CalculatorButton) {
        if button.isClearButton {
            fromValue = "0"
            toValue = "0"
        } else if let title = button.title {
            switch title {
            case ".":
                if !fromValue.contains(".") {
                    fromValue += "."
                }
            default:
                if fromValue == "0" {
                    fromValue = title
                } else {
                    fromValue += title
                }
            }
        }
        updateConversion()
    }
    
    private func updateConversion() {
        if let value = Double(fromValue), let coinPrice = Double(selectedCoin.price ?? "1") {
            let convertedValue = value * coinPrice * selectedCurrency.price
            toValue = String(format: "%.2f", convertedValue)
        }
    }
    
}
