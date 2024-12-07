//
//  FirstLaunchView.swift
//  FootballTokens
//
//  Created by Michael on 12/6/24.
//

import SwiftUI

struct FirstLaunchView: View {
    
    @Binding var isFirstLaunch: Bool
    @State private var isAnimating = false
    
    var body: some View {
        
        ZStack {
            // background layer
            Color.backgroundColor.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                imageSection
                welcomeTextSection
                letsGoButton
            }
        }
    }
}

#Preview {
    FirstLaunchView(isFirstLaunch: .constant(true))
}

extension FirstLaunchView {
    
    private var imageSection: some View {
        Image(.welcome)
            .resizable()
            .scaledToFit()
            .padding()
            .padding(.leading, 25)
    }
    
    private var welcomeTextSection: some View {
        VStack {
            Text("For football fanatics and crypto enthusiasts alike")
                .foregroundStyle(Color.textColor.primary)
                .font(.system(size: 30, weight: .semibold))
                .padding()
            
            Text("Discover and explore a vast collection of fan tokens from football clubs around the world")
                .foregroundStyle(Color.textColor.primary)
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
        }
    }
    
    private var letsGoButton: some View {
        Button {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isFirstLaunch = true
                }
            }
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.accentsColor.accent)
                .overlay {
                    Text("Let's go")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.textColor.primary)
                }
                .padding()
                .padding(.top, 50)
        }
    }
}