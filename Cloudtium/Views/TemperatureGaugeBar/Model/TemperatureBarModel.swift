//
//  TemperatureBarModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/3/23.
//

import Foundation

struct TemperatureBarModel: Identifiable {
    let id = UUID()
    var value: CGFloat?
    var minimunValue: CGFloat
    var maximimValue: CGFloat
    var minimunTrackValue: CGFloat
    var maximimTrackValue: CGFloat
}

// MARK: - Mock Data
extension TemperatureBarModel {

    static var mockData: [TemperatureBarModel] {
        return [
            TemperatureBarModel(
                value: 24,
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 11,
                maximimTrackValue: 24
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 11,
                maximimTrackValue: 26
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 13,
                maximimTrackValue: 26
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 16,
                maximimTrackValue: 28
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 14,
                maximimTrackValue: 28
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 15,
                maximimTrackValue: 29
            ),
            TemperatureBarModel(
                minimunValue: 11,
                maximimValue: 32,
                minimunTrackValue: 16,
                maximimTrackValue: 32
            )
        ]
    }

}
