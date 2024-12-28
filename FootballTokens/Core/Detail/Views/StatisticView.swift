//
//  StatisticView.swift
//  FootballTokens
//
//  Created by Michael on 11/27/24.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        
        HStack(spacing: 0) {
            VStack {
                Text(stat.title)
                    .setFont(.nunitoSansRegular, size: 14)
                    .foregroundStyle(Color.textColor.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(stat.description ?? "")
                    .setFont(.nunitoSansRegular, size: 12)
                    .foregroundStyle(Color.textColor.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            VStack {
                Text(stat.value)
                    .setFont(.nunitoSansBold, size: 16)
                    .foregroundStyle(Color.textColor.primary)
                    .frame(maxWidth: 160, maxHeight: 70, alignment: .topTrailing)
                
            }
        }
    }
}

#Preview {
    StatisticView(stat: StatisticModel(title: "Market cap", description: nil, value: "20 million ARG"))
}
