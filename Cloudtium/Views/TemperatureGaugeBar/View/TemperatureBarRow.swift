//
//  TemperatureBarRow.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/3/23.
//

import SwiftUI

struct TemperatureBarRow: View {
    var data: TemperatureBarModel

    private var offset: CGFloat {
        let offset = (data.minimunTrackValue - data.minimunValue) / (data.maximimValue - data.minimunValue)
        return offset
    }

    private var width: CGFloat {
        let max = (data.maximimTrackValue - data.minimunValue) / (data.maximimValue - data.minimunValue)
        let min = (data.minimunTrackValue - data.minimunValue) / (data.maximimValue - data.minimunValue)
        return max - min
    }

    var body: some View {
        HStack {
            Text("\(Int(data.minimunTrackValue))°")
                .frame(width: 30, alignment: .trailing)
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    TemperatureBarBackgroundView()
                    TemperatureBarView(data: data)
                        .frame(width: width * proxy.size.width)
                        .offset(x: proxy.size.width * offset)
                }
            }
            .frame(height: 6)
            Text("\(Int(data.maximimTrackValue))°")
                .frame(width: 30, alignment: .trailing)
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .fontDesign(.rounded)
        .multilineTextAlignment(.leading)
    }
}

struct TemperatureBarRow_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureBarRow(data: TemperatureBarModel.mockData.first!)
    }
}
