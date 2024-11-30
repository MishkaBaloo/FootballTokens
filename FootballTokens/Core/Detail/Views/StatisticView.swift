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
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.textColor.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(stat.description ?? "")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(Color.textColor.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            VStack {
                Text(stat.value)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.textColor.primary)
                    .frame(maxWidth: 140, maxHeight: 70, alignment: .topTrailing)
                
            }
        }
    }
}

#Preview {
    StatisticView(stat: StatisticModel(title: "Market cap", description: nil, value: "20 million ARG"))
}
