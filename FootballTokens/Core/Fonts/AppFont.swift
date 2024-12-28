//
//  AppFont.swift
//  FootballTokens
//
//  Created by Michael on 12/11/24.
//

import Foundation
import SwiftUI

enum Fonts {
    
    case nunitoSansBold
    case nunitoSansRegular
    

    static let NunitoSansBold = "NunitoSans-Bold"
    static let NunitoSansRegular = "NunitoSans-Regular"
    
    func getfont(size: Int) -> Font {
        
        switch self {
            
        case .nunitoSansBold: Font.custom(Fonts.NunitoSansBold, size: size.adaptive)
        case .nunitoSansRegular: Font.custom(Fonts.NunitoSansRegular, size: size.adaptive)
            
        }
    }
}

extension View {
  @ViewBuilder func setFont(_ font: Fonts, size: Int) -> some View {
    self.font(font.getfont(size: size))
  }
}
