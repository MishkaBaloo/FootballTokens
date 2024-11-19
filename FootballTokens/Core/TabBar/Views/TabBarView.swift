//
//  TabBarView.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct TabBarView: View {
    
    let tabs: [TabBarItems]
    @Binding var selection: TabBarItems
    @State var localSelection: TabBarItems
    @Namespace private var namespace
    @State private var stroke: Bool = true
    
    var body: some View {
        
        tabBar
            .onChange(of: selection) { oldValue, newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

struct CustomTabbarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItems] = [.overview, .calculator, .settings]
    
    static var previews: some View {
        VStack {
            
            Spacer()
            
            TabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}

//MARK: Extensions

extension TabBarView {
    
    @ViewBuilder private func getTabImage(for tab: TabBarItems) -> some View {
      (localSelection == tab ? tab.activeIcon : tab.defaultIcon)
        .resizable()
        .frame(width: 24, height: 24)
        .padding(.top, 8)
        .onTapGesture {
          switchToTab(tab: tab)
        }
    }
    
    private var tabBar: some View {
        VStack(spacing: 0) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.strokeColor.primary)
            
            HStack(alignment: .center, spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    VStack(spacing: 8) {
                        if selection == tab {
                            RoundedRectangle(cornerRadius: 1.5)
                                .frame(width: 50, height: 3)
                                .matchedGeometryEffect(id: "selection", in: namespace)
                                .foregroundStyle(Color.accentsColor.accent)
                        } else {
                            Color.clear
                                .frame(width: 50, height: 3)
                        }
                        
                        getTabImage(for: tab)
                        
                        Text(tab.title)
                            .font(.system(size: 12))
                            .foregroundStyle(localSelection == tab ? Color.accentsColor.accent : Color.textColor.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
                }
            }
            .animation(.smooth, value: selection)
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity)
        .background(Color.backgroundColor.background.ignoresSafeArea(edges: .bottom))
        
    }
    
    private func switchToTab(tab: TabBarItems) {
        selection = tab
    }
    
}
