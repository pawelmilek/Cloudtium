//
//  TemperatureBarBackgroundView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/3/23.
//

import SwiftUI

struct TemperatureBarBackgroundView: View {
    var body: some View {
        Capsule()
            .fill(.quaternary)
            .foregroundStyle(ColorStyle.secondary)
            .frame(height: 6)
    }
}

struct TemperatureBarBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureBarBackgroundView()
    }
}
