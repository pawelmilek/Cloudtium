//
//  Style.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation
import SwiftUI

enum ColorStyle {
    static let primary = Color("primary")
    static let secondary = Color("secondary")
    static let capsule = Color("capsule")
    static let condition = Color("condition")
    static let accent = Color("accent")
    static let background = Color("background")
    static let favoriteBackground = Color("favoriteBackground")

    static let text = Color("text")
    static let textDark = Color("textDark")
    static let textLight = Color("textLight")

    static let sunsetGradientStart = Color("sunsetGradientStart")
    static let sunsetGradientEnd = Color("sunsetGradientEnd")
}

enum PaddingStyle {
    static let horizontal = CGFloat(26)
    static let vertical = CGFloat(13)
}

enum Style {
    static let narrowTemperatureStyle = Measurement<UnitTemperature>.FormatStyle(
        width: .narrow,
        usage: .weather,
        numberFormatStyle: FloatingPointFormatStyle().precision(.fractionLength(0))
    )
}
