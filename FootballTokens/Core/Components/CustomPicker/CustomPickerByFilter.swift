//
//  CustomPickerByFilter.swift
//  FootballTokens
//
//  Created by Michael on 11/21/24.
//

import SwiftUI

struct CustomPickerByFilter: View {
    var defaultSelection: Sorting = .marketCup
    var anchor: Anchor = .bottom
    var cornerRadius: CGFloat = 10
    
    @Binding var selection: Sorting
    @State private var showTimePerios: Bool = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0
    
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .trailing, spacing: 0) {
                SquareButton(image: Image(showTimePerios ? .close : .filter)) {
                    withAnimation(.snappy) {
                        index += 1
                        zIndex = index
                        showTimePerios.toggle()
                    }
                }
                .frame(width: 44, height: 44)
                .rotationEffect(Angle(degrees: showTimePerios ? -180 : 0))
               
                VStack {
                    if showTimePerios {
                        TimePeriodsView()
                    }
                }
                .padding(.top, 8)
                .clipped()
                .frame(width: 190)
                .shadow(color: Color.shadow, radius: 12, y: 4)
            }
            .frame(width: 44, alignment: .trailing)
        }
        .frame(width: 44, height: 44)
        .zIndex(zIndex)
    }
    
    @ViewBuilder
    func TimePeriodsView() -> some View {
        VStack(spacing: 0) {
            ForEach(Sorting.allCases, id: \.self) { sortingOption in
                VStack(spacing: 0) {
                    if sortingOption != Sorting.allCases.first {
                        Divider()
                            .frame(height: 1)
                            .background(Color.black)
                    }
                    
                    HStack(spacing: 0) {
                        Text(sortingOption.keyword)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(selection == sortingOption ? Color.supportColor.success : Color.textColor.primary)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.supportColor.success)
                            .opacity(selection == sortingOption ? 1 : 0)
                            .padding(.trailing)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.leading)
                    .frame(height: 44)
                    .background(
                        selection == sortingOption
                            ? Color.layersColor.layerTwo
                            : Color.layersColor.layerFour
                    )
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selection = sortingOption
                            showTimePerios = false
                            print("Market filter changed to: \(sortingOption)")
                        }
                    }
                }
            }
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.strokeColor.primary, lineWidth: 1)
        )
        .transition(.scale(scale: 0.1, anchor: .top))
        .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
}

#Preview {
    CustomPickerByFilter(
        defaultSelection: .marketCup,
        selection: .constant(.marketCup)
    )
}


