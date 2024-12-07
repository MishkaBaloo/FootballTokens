//
//  CalculatorButtons.swift
//  FootballTokens
//
//  Created by Michael on 12/7/24.
//

import Foundation
import SwiftUI

struct CalculatorButton: Identifiable {
    let id = UUID()
    var title: String?
    var Image: Image?
    var colorText: Color = Color.textColor.primary
    var isClearButton: Bool = false
}
