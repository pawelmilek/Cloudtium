//
//  AccentButtonStyle.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/17/23.
//

import Foundation
import SwiftUI

struct AccentButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .font(.subheadline)
      .foregroundColor(ColorStyle.background)
      .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
      .background(ColorStyle.accent)
      .clipShape(Capsule())
  }
}
