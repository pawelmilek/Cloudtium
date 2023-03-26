//
//  BackgroundView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/11/23.
//

import SwiftUI

struct BackgroundView: View {
    let color: Color

    var body: some View {
        GeometryReader { proxy in
            color
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
        }
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(color: ColorStyle.background)
    }
}
