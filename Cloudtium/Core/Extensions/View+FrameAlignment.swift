//
//  View+FrameAlignment.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/5/23.
//

import Foundation
import SwiftUI

enum FrameAlignment {
    case top, bottom, leading, trailing, center
}

extension View {

    @ViewBuilder
    func frameAlignment(_ alignment: FrameAlignment) -> some View {
        switch alignment {
        case .top:
            self.frame(maxHeight: .infinity, alignment: .top)
        case .bottom:
            self.frame(maxHeight: .infinity, alignment: .bottom)
        case .leading:
            self.frame(maxWidth: .infinity, alignment: .leading)
        case .trailing:
            self.frame(maxWidth: .infinity, alignment: .trailing)
        case .center:
            self.frame(maxWidth: .infinity, alignment: .center)
        }
    }

}
