//
//  DetailView.swift
//  FootballTokens
//
//  Created by Michael on 11/28/24.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @Environment(\.dismiss) var presentationMode
    @StateObject private var vm: DetailViewModel
    @State private var selectionTime: TimePeriods = .day
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        
        // background layer
        ZStack {
            Color.backgroundColor.background.ignoresSafeArea()
            
            // content layer
            VStack(spacing: 0) {
                header
                coinInfo
                sorting
                    .zIndex(10)
                chart
                ScrollView {
                    stat
                        .onChange(of: selectionTime, { oldValue, newValue in
                            vm.updateCoins(for: newValue)
                        })
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.all)
                .padding(.top)
                tabBar
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.updateCoins(for: selectionTime)
        }
    }
}

#Preview {
    DetailView(coin: CoinModel.mok)
}

extension DetailView {
    
    private var header: some View {
        HStack {
            SquareButton(image: Image(.arrowBack)) {
                presentationMode.callAsFunction()
            }
            Spacer()
            SquareButton(image: Image(.favorite)) {
                // saving coin
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    private var coinInfo: some View {
        DetailPerformingView(coin: vm.coin)
            .padding(.top, 4)
    }
    
    private var sorting: some View {
        HStack {
            Text(Date().asShortDateString())
                .font(.system(size: 14, weight: .bold))
            Spacer()
            CustomPickerByTimePeriod(defaultSelection: .day, selection: $selectionTime)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 4)
    }
    
    private var chart: some View {
        DetailChartView(data: $vm.chartData, timePeriod: selectionTime)
            .padding(.top, 4)
    }
    
    private var stat: some View {
        VStack {
            Text("Supply information")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textColor.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            VStack(spacing: 0) {
                ForEach(vm.supplyInformation) { stat in
                    if stat != vm.supplyInformation.first {
                        Divider()
                            .background(Color.strokeColor.secondary)
                            .padding(.horizontal)
                    }
                    
                    StatisticView(stat: stat)
                        .padding(.top)
                        .padding(.horizontal)
                }
            }
            .background(Color.layersColor.layerTwo)
            .clipShape(.rect(cornerRadius: 20))
            .padding(.horizontal)
            
            Spacer()
            
            Text("Value statistics")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textColor.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            
            VStack(spacing: 0) {
                ForEach(vm.valueStatistic) { stat in
                    
                    if stat != vm.valueStatistic.first {
                        Divider()
                            .frame(height: 1)
                            .background(Color.strokeColor.secondary)
                            .padding(.horizontal)
                    }

                    StatisticView(stat: stat)
                        .padding(.top)
                        .padding(.horizontal)
                        .padding(.bottom, stat.description != nil ? 10 : 0)
                }
            }
            .background(Color.layersColor.layerTwo)
            .clipShape(.rect(cornerRadius: 20))
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    private var tabBar: some View {
        VStack(spacing: 0) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.strokeColor.primary)
                .edgesIgnoringSafeArea(.horizontal)
            
            HStack(spacing: 0) {
                if let websiteString = vm.websiteURL,
                   let url = URL(string: websiteString) {
                    Link(destination: url, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.accentsColor.accent)
                            .overlay {
                                Text("Go to website")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(Color.textColor.primary)
                            }
                    })
                }
                
                Spacer()
                
                if let websiteString = vm.websiteURL,
                   let url = URL(string: websiteString) {
                    ShareLink(item: url) {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color.layersColor.layerOne)
                            
                            Image(.share)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .padding(.bottom, 4)
    }
    
}
