//
//  NoDataView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import SwiftUI

struct NoDataView: View {
    let title: String
    let description: String

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.background)
            VStack(spacing: 10) {
                VStack {
                    Image(systemName: "clock.badge.exclamationmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color("primary"), Color("secondary")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                    Text(title)
                        .foregroundColor(ColorStyle.text)
                }
                .font(.headline)
                .fontWeight(.heavy)

                Text(description)
                    .font(.caption)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(ColorStyle.textLight)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(
            title: "Oops! Something went wrong.",
            description: "Data not found, please try again later."
        )
    }
}
