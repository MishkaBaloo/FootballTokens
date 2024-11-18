//
//  Favorite.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct Favorite: View {
    
    @Environment(\.dismiss) var presentationMode
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                header
                Spacer()
                notSavedTokensText
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Favorite()
}

//MARK: Extensions

extension Favorite {
    
    private var header: some View {
        HStack {
            SquareButton(
                image: Image(.arrowBack),
                action: {
                    presentationMode.callAsFunction()
                }
            )
            
            Spacer()
            
            Text("Favorite")
                .foregroundStyle(Color.textColor.primary)
                .font(.headline)
                .fontWeight(.heavy)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.backgroundColor.background)
                
            }
        }
        .padding(.horizontal)
    }
    
    private var notSavedTokensText: some View {
        HStack {
            Text("No favorites Fan Tokens yet")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.textColor.secondary)
        }
    }
    
}
