//
//  DetailChartView.swift
//  FootballTokens
//
//  Created by Michael on 11/29/24.
//

import SwiftUI

struct DetailChartView: View {
    
    @Binding var data: [Double]
    
    private let timePeriod: TimePeriods
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    @State private var tappedXPosition: CGFloat? = nil
    @State private var tappedYPosition: CGFloat? = nil
    @State private var tappedPrice: Double? = nil
    
    init(data: Binding<[Double]>, timePeriod: TimePeriods) {
        self._data = data
        self.timePeriod = timePeriod
        self.maxY = data.wrappedValue.max() ?? 0
        self.minY = data.wrappedValue.min() ?? 0
        let priceChange = (data.wrappedValue.last ?? 0) - (data.wrappedValue.first ?? 0)
        self.lineColor = priceChange > 0 ? Color.supportColor.success : Color.supportColor.error
        self.endingDate = Date()
        self.startingDate = Calendar.current.date(byAdding: .hour, value: -timePeriod.hours, to: endingDate) ?? Date()
    }
    
    var body: some View {
        VStack {
            if data.isEmpty {
                ProgressView("Loading chart...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                chartView
                    .padding(.top)
                    .frame(height: 100)
                    .background(chartVackground)
                    .overlay(alignment: .trailing) {
                        chartYAxic
                    }
                chartDateLabel
            }
        }
        .onChange(of: data) { oldValue, newValue in
            percentage = 0
            withAnimation(.linear(duration: 2)) {
                percentage = 1
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
    
    private var isScrollable: Bool {
        timePeriod == .month || timePeriod == .year
    }

    private var chartWidth: CGFloat {
        switch timePeriod {
        case .month:
            return UIScreen.main.bounds.width * 1.5
        case .year:
            return UIScreen.main.bounds.width * 3
        default:
            return UIScreen.main.bounds.width
        }
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let xStep = width / CGFloat(data.count - 1)
            let yRange = maxY - minY
            let xStepScroll = chartWidth / CGFloat(data.count - 1)
            let yRangeScroll = maxY - minY

            ZStack {
                if isScrollable {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ZStack {
                            createChartPath(
                                xStep: xStepScroll,
                                yRange: yRangeScroll,
                                width: chartWidth,
                                height: height,
                                isScrollable: true
                            )
                        }
                    }
                    .scrollIndicators(.hidden)
                } else {
                    createChartPath(
                        xStep: xStep,
                        yRange: yRange,
                        width: width,
                        height: height,
                        isScrollable: false
                    )
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            percentage = 0
            withAnimation(.easeInOut(duration: 2.0)) {
                percentage = 1
            }
        }
    }

    @ViewBuilder
    private func createChartPath(
        xStep: CGFloat,
        yRange: CGFloat,
        width: CGFloat,
        height: CGFloat,
        isScrollable: Bool) -> some View {
        
        // path line
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
        .frame(width: isScrollable ? chartWidth : width)

        // gradient body
        if percentage == 1 {
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
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        lineColor.opacity(0.8),
                        lineColor.opacity(0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: isScrollable ? chartWidth : width)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let tapX = value.location.x
                        let index = min(max(Int((tapX / xStep).rounded()), 0), data.count - 1)
                        tappedXPosition = CGFloat(index) * xStep
                        tappedYPosition = (1 - CGFloat((data[index] - minY) / yRange)) * height
                        tappedPrice = data[index]
                    }
                    .onEnded { _ in
                        tappedXPosition = nil
                        tappedYPosition = nil
                        tappedPrice = nil
                    }
            )
        }
            
        // tap components
        if let xPosition = tappedXPosition,
           let yPosition = tappedYPosition,
           let price = tappedPrice {
            ZStack {
                Rectangle()
                    .frame(width: 1, height: height - yPosition)
                    .foregroundColor(Color.iconColor.icon)
                    .position(x: xPosition, y: height - (height - yPosition) / 2)
                    .animation(.easeInOut(duration: 0.3), value: yPosition)

                VStack(spacing: 0) {
                    Text("$\(price, specifier: "%.2f")")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color.textColor.secondary)
                        .padding(4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.iconColor.icon)
                        )
                        .offset(y: yPosition - 20)

                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.iconColor.icon)
                        .offset(y: yPosition - 10)
                }
                .position(x: xPosition)
                .animation(.easeInOut(duration: 0.3), value: price)
            }
        }
    }
}

#Preview {
    DetailView(coin: CoinModel.mok)
}
