//
//  SettingRowView.swift
//  FootballTokens
//
//  Created by Michael on 12/7/24.
//

import SwiftUI

import SwiftUI

struct SettingRowView: View {
    let image: Image
    let title: String
    let action: () -> Void

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.layersColor.layerTwo)
                .overlay {
                    HStack {
                        image
                        Text(title)
                            .foregroundStyle(Color.textColor.primary)
                            .font(.system(size: 16, weight: .heavy))
                        Spacer()
                        SquareButton(image: Image(.arrowRight), action: action)
                    }
                    .padding(.horizontal)
                }
        }
        .padding(.horizontal)
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(
            image: Image(.privacy),
            title: "Privacy policy",
            action: {
                if let url = URL(string: AppConfig.privacyPolicyLink) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url)
                    }
                }
            }
        )
    }
}
