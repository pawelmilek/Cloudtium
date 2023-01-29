//
//  AttributionFooterView.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI

struct AttributionFooterView: View {
  let logo: URL?
  let link: URL?

  var body: some View {
    if let logo, let link {
      Link(destination: link, label: {
        AsyncImage(url: logo) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          ProgressView()
        }
      })
      .frame(width: 50, height: 10)
    }
  }
}


struct AttributionFooterView_Previews: PreviewProvider {
  static var previews: some View {
    let linkURL = URL(string: "www.google.com")
    let imageURL = URL(string: "https://cdn.pixabay.com/photo/2015/03/10/17/23/youtube-667451__480.png")

    AttributionFooterView(logo: imageURL, link: linkURL)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}

