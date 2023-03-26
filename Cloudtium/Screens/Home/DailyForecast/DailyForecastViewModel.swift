//
//  DailyForecastViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 15/01/2023.
//

import WeatherKit
import Combine
import Foundation
import SwiftUI

final class DailyForecastViewModel: ObservableObject {
    @Published var title: String
    @Published var currentTemperature: Measurement<UnitTemperature>
    @Published var tenDaysForecast: [DayWeather]

    init(currentWeather: CurrentWeather, dailyWeather: Forecast<DayWeather>) {
        title = "Daily forecast"
        currentTemperature = currentWeather.temperature
        tenDaysForecast = Array(dailyWeather.forecast.prefix(10))
    }

    func day(_ dayWeather: DayWeather) -> String {
        dayWeather.date.abbreviatedDay
    }

    func temperatureBarData(_ dayWeather: DayWeather) -> TemperatureBarModel {
        TemperatureBarModel(
            value: currentTemperature.value,
            minimunValue: dayWeather.lowTemperature.value,
            maximimValue: dayWeather.highTemperature.value,
            minimunTrackValue: dayWeather.lowTemperature.value + 2,
            maximimTrackValue: dayWeather.highTemperature.value - 3
        )
    }

}
