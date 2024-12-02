//
//  Calculator.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Calculator: View {
    var body: some View {
        ZStack {
            
            Color.backgroundColor.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                Text("Calculator")
                    .foregroundStyle(Color.textColor.primary)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

#Preview {
    Calculator()
}
