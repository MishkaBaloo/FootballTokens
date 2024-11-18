//
//  ContentView.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.title)
                .fontWeight(.bold)
                
        }
        .foregroundStyle(Color.supportColor.success)
        .padding()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
