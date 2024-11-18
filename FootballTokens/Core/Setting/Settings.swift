//
//  Settings.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI
import StoreKit

struct Settings: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.background.ignoresSafeArea()
            
            // content layer
            VStack(spacing: 15) {
                
                // header
                Text("Settings")
                    .foregroundStyle(Color.textColor.primary)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                
                // about app
                VStack {
                    Text("Abbout app")
                        .foregroundStyle(Color.textColor.secondary)
                        .font(.system(size: 16, weight: .light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    

                    privacyPolicy
                    terms
                    
                    // feedback
                    Text("Feedback")
                        .foregroundStyle(Color.textColor.secondary)
                        .font(.system(size: 16, weight: .light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    share
                    rate
                    
                    // clearData button
                    Spacer()
                    clearData
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    Settings()
}

//MARK: Extensions

extension Settings {
    
    private var privacyPolicy: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 70)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    HStack {
                        Image(.privacy)
                        Text("Privacy policy")
                            .foregroundStyle(Color.textColor.primary)
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                        SquareButton(image: Image(.arrowRight)) {
                            if let url = URL(string: AppConfig.privacyPolicyLink) {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    private var terms: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 361, height: 70)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    HStack {
                        Image(.terms)
                        Text("Terms of use")
                            .foregroundStyle(Color.textColor.primary)
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                        SquareButton(image: Image(.arrowRight)) {
                            if let url = URL(string: AppConfig.termsOfUseLink) {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    private var share: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 361, height: 70)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    HStack {
                        Image(.share)
                        Text("Share this app")
                            .foregroundStyle(Color.textColor.primary)
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                        SquareButton(image: Image(.arrowRight)) {
                            
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    private var rate: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 70)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    HStack {
                        Image(.rate)
                        Text("Rate us")
                            .foregroundStyle(Color.textColor.primary)
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                        SquareButton(image: Image(.arrowRight)) {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: scene)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    private var clearData: some View {
        Button(action: {
            showAlert.toggle()
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.supportColor.error, lineWidth: 1)
                .frame(width: 360, height: 45)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    Text("Clear Data")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.supportColor.error)
                }
        })
        .alert("Clear Data", isPresented: $showAlert, actions: {
            Button(role: .cancel, action: {}) {
                Text("Cancel")
                    .foregroundStyle(Color.red)
            }
            Button(role: .destructive, action: {
                
            }) {
                Text("Clear")
            }
        }, message: {
            Text("Are you sure yu want to clear all your data? This action will premanently delete all your changes.")
        })
    }
}
