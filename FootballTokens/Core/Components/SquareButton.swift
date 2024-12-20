//
//  SquareButton.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct SquareButton: View {
    
    let image: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(width: 44, height: 44)
                    .foregroundStyle(Color.layersColor.layerOne)
                
                image
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        })
    }
}

#Preview {
    SquareButton(image: Image(.vector), action: {})
}
