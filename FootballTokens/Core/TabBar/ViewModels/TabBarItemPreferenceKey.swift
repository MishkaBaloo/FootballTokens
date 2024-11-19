//
//  TabBarItemPreferenceKey.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import Foundation
import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabBarItems] = []
    
    static func reduce(value: inout [TabBarItems], nextValue: () -> [TabBarItems]) {
        value += nextValue()
    }
    
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItems
    @Binding var selection: TabBarItems
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}


extension View {
    func tabBarItem(tab: TabBarItems, selection: Binding<TabBarItems>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
