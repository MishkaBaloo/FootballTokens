//
//  TabBarContainerView.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct TabBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItems
    @State private var tabs: [TabBarItems] = []
    
    let content: Content
    
    init(selection: Binding<TabBarItems>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            TabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
            .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItems] = [ .overview, .calculator, .settings]
    
    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            Color.blue
        }
     }
 }
