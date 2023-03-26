//
//  BigLogoView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/17/23.
//

import SwiftUI

struct BigLogoView: View {
    let imageName: String
    let gradientColors: [Color]

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 210, height: 210)
                .foregroundStyle(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .fontWeight(.heavy)
                .fontDesign(.rounded)
        }
    }
}

struct WelcomeLogoView_Previews: PreviewProvider {
    static let findViewModel = PageViewModel.makeFirstPageViewModel()
    static let locationViewModel = PageViewModel.makeSecondPageViewModel()

    static var previews: some View {
        BigLogoView(
            imageName: findViewModel.symbol,
            gradientColors: findViewModel.gradientColors
        )
        .previewDisplayName("Find Page")

        BigLogoView(
            imageName: locationViewModel.symbol,
            gradientColors: locationViewModel.gradientColors
        )
        .previewDisplayName("Location Page")
    }
}
