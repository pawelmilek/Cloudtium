//
//  Image+PaletteModifier.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/16/23.
//

import SwiftUI

extension Image {

    func imagePaletteModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .symbolVariant(.fill)
            .symbolRenderingMode(.palette)
            .fontDesign(.rounded)
            .foregroundStyle(ColorStyle.primary, ColorStyle.secondary)
    }

}
