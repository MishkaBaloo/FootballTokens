//
//  CustomPickerByTimePeriod.swift
//  FootballTokens
//
//  Created by Michael on 11/21/24.
//

import SwiftUI

struct CustomPickerByTimePeriod: View {
    
   
    var defaultSelection: TimePeriods = .day
    var anchor: Anchor = .bottom
    var cornerRadius: CGFloat = 10
    
    @Binding var selection: TimePeriods
    @State private var showTimePerios: Bool = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size

            VStack {
                HStack(spacing: 0) {
                    Text(selection.keyword)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.textColor.primary)
                    
                    Image(.arrowDown)
                        .padding(.leading, 6)
                        .rotationEffect(Angle(degrees: showTimePerios ? -180 : 0))
                }
                .frame(width: 88, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.strokeColor.primary, lineWidth: 1)
                )
                .zIndex(10)
                .background(Color.backgroundColor.background)
                .cornerRadius(10)
                .frame(width: size.width ,height: size.height, alignment: anchor == .top ? .bottom : .top)
                .onTapGesture {
                    withAnimation(.snappy) {
                        index += 1
                        zIndex = index
                        showTimePerios.toggle()
                    }
                }
                
                VStack {
                    if showTimePerios {
                        TimePeriodsView()
                    }
                }
                .clipped()
                .zIndex(20)
                .cornerRadius(cornerRadius)
                .shadow(color: Color.black, radius: 10)
            }
        }
        .frame(width: 88, height: 44)
        .zIndex(zIndex)
    }
    
    @ViewBuilder
    func TimePeriodsView() -> some View {
        VStack(spacing: 0) {
            ForEach(TimePeriods.allCases, id: \.self) { sortingTime in
                VStack(spacing: 0) {
                if sortingTime != TimePeriods.allCases.first {
                    Divider()
                        .frame(height: 1)
                        .background(Color.black)
                }
                    
                    HStack(spacing: 0) {
                        Text(sortingTime.keyword)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(selection == sortingTime ? Color.supportColor.success : Color.textColor.primary)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.supportColor.success)
                            .opacity(selection == sortingTime ? 1 : 0)
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 44)
                    .background(
                        selection == sortingTime
                            ? Color.layersColor.layerTwo
                        : Color.layersColor.layerFour
                    )
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selection = sortingTime
                            showTimePerios = false
                            print("Time period cnahged to: \(sortingTime)")
                        }
                    }
                }
            }
        }
        .clipShape(.rect(cornerRadius: cornerRadius))
        .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.strokeColor.primary, lineWidth: 1)
            )
        .frame(width: 88)
        .transition(.scale(scale: 1.5))
        
    }
}

#Preview {
    CustomPickerByTimePeriod(
        defaultSelection: .day,
        selection: .constant(.day)
    )
}
    
enum Anchor {
    case top
    case bottom
}
