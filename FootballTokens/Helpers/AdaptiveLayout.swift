//
//  AdaptiveLayout.swift
//  FootballTokens
//
//  Created by Michael on 12/11/24.
//

import Foundation
import SwiftUI

struct AdaptiveLayoutService {
  
  private let heightConstantFromFigmaDevice: CGFloat = 852
  private let widthConstantFromFigmaDevice: CGFloat = 393
  
  
  private func getAverageScaleCoefficientForCurrentDevice() -> Double {
    let heightCoefficient =  UIScreen.main.bounds.height / heightConstantFromFigmaDevice
    let widthCoefficient =  UIScreen.main.bounds.width / widthConstantFromFigmaDevice
    
    return ((heightCoefficient + widthCoefficient) / 2)
  }
  
  func calculate(_ constant: CGFloat) -> CGFloat {
    constant * getAverageScaleCoefficientForCurrentDevice()
  }
}

extension Int {
  var adaptive: CGFloat {
    AdaptiveLayoutService().calculate(CGFloat(self))
  }
}
