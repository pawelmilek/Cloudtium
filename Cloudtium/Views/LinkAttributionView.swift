//
//  LinkAttributionView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI

struct LinkAttributionView: View {
    let attribution: (link: URL, logo: URL)

    var body: some View {
        Link(destination: attribution.link) {
            AsyncImage(
                url: attribution.logo,
                transaction: Transaction(animation: .easeOut)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "applelogo")
                }
            }
        }
        .foregroundColor(ColorStyle.text)
    }
}
struct AttributionFooterView_Previews: PreviewProvider {
    static var previews: some View {
        let linkURL = URL(string: "www.google.com")!
        let imageURL = URL(string: "https://cdn.pixabay.com/photo/2015/03/10/17/23/youtube-667451__480.png")!

        LinkAttributionView(attribution: (linkURL, imageURL))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
