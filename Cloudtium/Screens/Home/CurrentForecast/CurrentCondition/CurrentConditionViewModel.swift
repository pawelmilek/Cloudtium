//
//  CurrentConditionViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/8/23.
//

import Foundation
import SwiftUI
import WeatherKit

final class CurrentConditionViewModel: ObservableObject {
    @Published var location: String
    @Published var symbol: String
    @Published var temperature: String
    @Published var maxMinTemperature: String
    @Published var shortConditionDescription: String
    @Published var gradientColors: [Color]

    init(locationName: String, current: CurrentWeather, daily: Forecast<DayWeather>) {
        location = locationName
        temperature = "\(Int(current.temperature.value))°"
        shortConditionDescription = current.condition.description
        gradientColors = [ColorStyle.primary, ColorStyle.secondary]
        symbol = current.symbolName

        if let today = daily.forecast.first {
            let highTemperature = "\(Int(today.highTemperature.value))°"
            let lowTemperature = "\(Int(today.lowTemperature.value))°"
            maxMinTemperature = "\(highTemperature) | \(lowTemperature)"
        } else {
            maxMinTemperature = ""
        }
    }
}
