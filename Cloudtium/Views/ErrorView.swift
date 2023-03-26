//
//  ErrorView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 02/01/2023.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.dismiss) var dismiss

    let title: String
    let description: String
    let showAction: Bool

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.background)
            VStack(spacing: 10) {
                VStack {
                    BigLogoView(
                        imageName: "exclamationmark.octagon.fill",
                        gradientColors: [Color("primary"), Color("secondary")]
                    )
                    Text(title)
                        .foregroundColor(ColorStyle.text)
                }
                .font(.largeTitle)
                .fontWeight(.heavy)

                Text(description)
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(ColorStyle.textLight)
            }
            .multilineTextAlignment(.center)
            VStack {
                Button {
                    dismiss()
                } label: {
                    Text("Ok")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
                .buttonStyle(AccentButtonStyle())
            }
            .frameAlignment(.bottom)
            .padding(.horizontal, 35)
            .padding(.vertical, 60)
            .opacity(showAction ? 1.0 : 0.0)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            title: "Oops! Something went wrong.",
            description: "The application has encountered an unknown error.",
            showAction: true
        )
        ErrorView(
            title: "Oops! Something went wrong.",
            description: "The application has encountered an unknown error.",
            showAction: false
        )
    }
}
