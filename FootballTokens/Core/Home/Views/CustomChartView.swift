//
//  CustomChartView.swift
//  FootballTokens
//
//  Created by Michael on 11/22/24.
//

import SwiftUI

struct CustomChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color = .success
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    @State private var tappedXPosition: CGFloat? = nil
    @State private var tappedYPosition: CGFloat? = nil
    @State private var tappedPrice: Double? = nil
    
    init(coin: CoinModel) {
        data = coin.sparkline.compactMap { Double($0 ?? "") }
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        endingDate = Date()
        startingDate = endingDate.addingTimeInterval(-24 * 60 * 60) // (-7*24*60*60) - week
    }
    
    var body: some View {
        
        
        VStack {
            chartView
                .padding(.top)
                .frame(height: 100)
                .background(chartVackground)
                .overlay(alignment: .trailing) {
                    chartYAxic
                }
            chartDateLabel
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 2)) {
                    percentage = 1
                }
            }
        }
    }
    
    private var chartVackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    private var chartYAxic: some View {
        VStack {
            Text("$" + maxY.formattedWithAbbreviations())
            Spacer()
            Text("$" + minY.formattedWithAbbreviations())
        }
        .padding(.horizontal)
        .foregroundStyle(Color.textColor.secondary)
        .font(.system(size: 12, weight: .bold))
    }
    
    private var chartDateLabel: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundStyle(Color.textColor.secondary)
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            let xStep = width / CGFloat(data.count - 1)
            let yRange = maxY - minY
            
            Path { path in
                for index in data.indices {
                    let xPosition = CGFloat(index) * xStep
                    let yPosition = (1 - CGFloat((data[index] - minY) / yRange)) * height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            
            Path { path in
                for index in data.indices {
                    let xPosition = CGFloat(index) * xStep
                    let yPosition = (1 - CGFloat((data[index] - minY) / yRange)) * height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }

                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: 0, y: height))
                path.closeSubpath()
            }
            .trim(from: 0, to: percentage)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.layerFive.opacity(1),
                        Color.layerFive.opacity(0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .padding(.horizontal)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                percentage = 1
            }
        }
    }
}

#Preview {
    CustomChartView(coin: CoinModel.mok)
}

