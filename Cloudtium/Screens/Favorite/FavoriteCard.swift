//
//  FavoriteCard.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/11/23.
//

import SwiftUI

struct FavoriteCard: View {
    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.background)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                )

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("22 º")
                        .foregroundColor(ColorStyle.text)
                    Spacer()
                    Image(systemName: "cloud.bolt.rain")
                        .imagePaletteModifier()
                        .frame(width: 38)
                }
                .font(.largeTitle)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                HStack {
                    Text("Austin")
                        .foregroundColor(ColorStyle.text)
                    Text("USA")
                        .foregroundColor(ColorStyle.textLight)
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                HStack {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "drop")
                            .foregroundColor(ColorStyle.condition)
                        Text("17%")
                    }
                    Spacer()
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "wind")
                            .foregroundColor(ColorStyle.condition)
                        Text("7km/h")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.subheadline)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundColor(ColorStyle.text)
            }
            .padding(12)
        }
    }
}

struct FavoriteCard_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCard()
            .previewLayout(.sizeThatFits)
    }
}
