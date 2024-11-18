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
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.layersColor.layerOne)
                
                image
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        })
    }
}

#Preview {
    SquareButton(image: Image(.tokenPlaceholder), action: {})
}
