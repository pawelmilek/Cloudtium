//
//  HourlyForecastChartViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 12/01/2023.
//

import WeatherKit
import Combine
import Foundation
import SwiftUI

class HourlyForecastChartViewModel {
    enum Constant {
        static let minYScale = 150
        static let maxYScale = 240
        static let chartWidth: CGFloat = 350
        static let chartHeight: CGFloat = 140
        static let dataPointWidth: CGFloat = 65
    }

    private(set) var forecast: [HourWeather]

    var numberOfHours: Int { forecast.count }

    var maxTemperature: Measurement<UnitTemperature> {
        let result = forecast.map { $0.temperature }.max()
        return result!
    }

    var minTemperature: Measurement<UnitTemperature> {
        let result = forecast.map { $0.temperature }.min()
        return result!
    }

    var gradient: LinearGradient {
        LinearGradient(colors: [ColorStyle.primary, ColorStyle.secondary],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }

    init(forecast: Forecast<HourWeather>) {
        self.forecast = Array(forecast.forecast.prefix(12))
    }
}
