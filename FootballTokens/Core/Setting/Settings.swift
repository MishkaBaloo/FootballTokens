//
//  Settings.swift
//  FootballTokens
//
//  Created by Michael on 11/18/24.
//

import SwiftUI
import StoreKit

struct Settings: View {
    
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @State private var showAlert: Bool = false
    
    private let favoriteDataService = FavoritesDataService()

    
    var body: some View {
        ZStack {
            
            // background layer
            Color.backgroundColor.background.ignoresSafeArea()
            
            // content layer
            VStack(spacing: 15) {
                // header
                Text("Settings")
                    .foregroundStyle(Color.textColor.primary)
                    .font(.headline)
                    .fontWeight(.heavy)
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
                    Spacer(minLength: 100)
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    Settings()
        .environmentObject(TabBarViewModel())
}

//MARK: Extensions

extension Settings {
    
    private var privacyPolicy: some View {
        SettingRowView(image: Image(.privacy), title: "Privacy policy") {
            if let url = URL(string: AppConfig.privacyPolicyLink) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    private var terms: some View {
        SettingRowView(image: Image(.terms), title: "Terms of use") {
            if let url = URL(string: AppConfig.termsOfUseLink) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    private var share: some View {
        SettingRowView(image: Image(.share), title: "Share this app") {
            // share code
        }
    }
    
    private var rate: some View {
        SettingRowView(image: Image(.rate), title: "Rate us") {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    private var clearData: some View {
        Button(action: {
            showAlert.toggle()
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.supportColor.error, lineWidth: 1)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
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
                favoriteDataService.clearCache()
                tabBarViewModel.changeTab(tab: .overview)
            }) {
                Text("Clear")
            }
        }, message: {
            Text("Are you sure you want to clear all your data? This action will premanently delete all your changes.")
        })
    }
}
