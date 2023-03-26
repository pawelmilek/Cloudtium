//
//  UserLocationView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 16/01/2023.
//
// swiftlint:disable type_name

import SwiftUI

struct UserLocationView: View {
    let location: String

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.background)

            VStack(spacing: 10) {
                HStack(spacing: 5) {
                    Image(systemName: "location.circle")
                    Text("Your Location Now")
                        .lineLimit(1)
                }
                .font(.footnote)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundColor(ColorStyle.textLight)

                Text(location)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .lineLimit(1)
                    .foregroundColor(ColorStyle.text)
            }
        }
        .frame(height: 70)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserLocationView(location: "Chicago, IL, US")
}
