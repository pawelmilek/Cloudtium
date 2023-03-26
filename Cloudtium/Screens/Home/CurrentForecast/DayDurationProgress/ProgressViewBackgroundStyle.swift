//
//  ProgressViewBackgroundStyle.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import Foundation
import SwiftUI

struct ProgressViewBackgroundStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .padding(.vertical, 5)
            .background(ColorStyle.background)
            .tint(ColorStyle.secondary)
    }
}
