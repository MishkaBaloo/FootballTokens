//
//  Color.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let backgroundColor = BackgroundColor()
    static let layersColor = LayersColor()
    static let accentColor = AccentColor()
    static let textColor = TextColor()
    static let iconColor = IconColor()
    static let strokeColor = StrokeColor()
    static let buttonsColor = ButtonsColor()
    static let supportColor = SupportColor()
    
}

struct BackgroundColor {
    
    let background = Color("BackgroundColor")
    
}

struct LayersColor {
    
    let layerOne = Color("LayerOne")
    let layerTwo = Color("LayerTwo")
    let layerThree = Color("LayerThree")
    let layerFour = Color("LayerFour")
    let layerFive = Color("LayerFive")
    
}

struct AccentColor {
    
    let accent = Color("AccentColor")
    
}

struct TextColor {
    
    let primary = Color("PrimaryText")
    let secondary = Color("SecondaryText")
    
}

struct IconColor {
    
    let icon = Color("IconColor")
    
}

struct StrokeColor {
    
    let primary = Color("PrimaryStroke")
    let secondary = Color("SecondaryStroke")
    let tertiary = Color("TertiaryStroke")
    
}

struct ButtonsColor {
    
    let pressed = Color("Pressed")
    let disabled = Color("Disabled")
    
}

struct SupportColor {
    
    let success = Color("Success")
    let error = Color("Error")
    
}
