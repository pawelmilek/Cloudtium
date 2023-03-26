//
//  AttributedString+Colored.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/16/23.
//

import SwiftUI

extension AttributedString {

    static func colored(_ value: String, color: Color) -> AttributedString {
        var result = AttributedString(value)
        result.foregroundColor = color
        result.font = .title.bold()
        return result
    }

}
