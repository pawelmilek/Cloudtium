//
//  LocationDescriptionView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/17/23.
//

import SwiftUI

struct DescriptionView: View {
  let title: AttributedString
  let subheadline: String

  var body: some View {
    VStack(spacing: 20) {
      Text(title)
        .font(.title)
        .fontWeight(.heavy)
        .foregroundColor(ColorStyle.text)
      Text(subheadline)
        .font(.headline)
        .fontWeight(.bold)
        .frame(width: 200)
        .foregroundColor(ColorStyle.textLight)
    }
    .fontDesign(.rounded)
    .multilineTextAlignment(.center)
  }
}

struct LocationDescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    DescriptionView(
      title: AttributedString(stringLiteral: "Would you like to share your location?"),
      subheadline: "Start sharing your location with us"
    )
  }
}
