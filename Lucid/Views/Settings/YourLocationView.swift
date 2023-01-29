//
//  YourLocationView.swift
//  Lucid
//
//  Created by Pawel Milek on 16/01/2023.
//

import SwiftUI

struct YourLocationView: View {
  var placeName: String

  var body: some View {
    ZStack {
      ColorStyle.background.ignoresSafeArea()
      VStack(alignment: .center, spacing: 10) {
        HStack(alignment: .center, spacing: 5) {
          Image(systemName: "location.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15, alignment: .center)
          Text("Your Location Now")
            .font(.footnote)
            .fontWeight(.medium)
            .lineLimit(1)
        }
        .foregroundColor(ColorStyle.textLight)

        Text(placeName)
          .font(.body)
          .fontWeight(.medium)
          .lineLimit(1)
          .foregroundColor(ColorStyle.text)
      }
    }
    .frame(height: 70, alignment: .center)
  }
}

