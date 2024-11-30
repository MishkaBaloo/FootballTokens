//
//  DetailChartView.swift
//  FootballTokens
//
//  Created by Michael on 11/29/24.
//

import SwiftUI

struct DetailChartView: View {
    
    @Binding var data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0

    init(data: Binding<[Double]>, timePeriod: TimePeriods) {
        self._data = data
        self.maxY = data.wrappedValue.max() ?? 0
        self.minY = data.wrappedValue.min() ?? 0
        let priceChange = (data.wrappedValue.last ?? 0) - (data.wrappedValue.first ?? 0)
        self.lineColor = priceChange > 0 ? Color.supportColor.success : Color.supportColor.error
        self.endingDate = Date()
        self.startingDate = Calendar.current.date(byAdding: .hour, value: -timePeriod.hours, to: endingDate) ?? Date()
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
        .onChange(of: data) { oldValue, newValue in
            percentage = 0
            withAnimation(.linear(duration: 2)) {
                percentage = 1
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if !data.isEmpty {
                    withAnimation(.linear(duration: 2)) {
                        percentage = 1
                    }
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
                        lineColor.opacity(1),
                        lineColor.opacity(0)
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
