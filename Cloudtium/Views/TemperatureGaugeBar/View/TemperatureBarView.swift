//
//  TemperatureBarView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/3/23.
//

import SwiftUI

struct TemperatureBarView: View {
    var data: TemperatureBarModel

    private var startPoint: UnitPoint {
        let offset = (0 - data.minimunTrackValue) / (data.maximimTrackValue - data.minimunTrackValue)
        return UnitPoint(
            x: offset,
            y: 0.5
        )
    }

    private var endPoint: UnitPoint {
        let offset = (35 - data.minimunTrackValue) / (data.maximimTrackValue - data.minimunTrackValue)
        return UnitPoint(
            x: offset,
            y: 0.5
        )
    }

    private let colors: [Color] = [ColorStyle.primary, ColorStyle.secondary]
    private let height = CGFloat(6)

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: colors,
                            startPoint: startPoint,
                            endPoint: endPoint
                        )
                    )
                    .frame(height: height)
                if let value = data.value {
                    Circle()
                        .strokeBorder(Color.white.opacity(0.4), lineWidth: 2.0)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .padding(2.0)
                        )
                        .frame(width: height, height: height)
                        .offset(x: (proxy.size.width - height) * offset(for: value))
                }
            }
        }
        .frame(height: height)
    }

    private func offset(for value: CGFloat) -> CGFloat {
        if value < data.minimunTrackValue { return 0 }
        if value > data.maximimTrackValue { return 1 }
        let offset = (value - data.minimunTrackValue) / (data.maximimTrackValue - data.minimunTrackValue)
        return offset
    }
}

struct TemperatureBarView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureBarView(data: TemperatureBarModel.mockData.first!)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
