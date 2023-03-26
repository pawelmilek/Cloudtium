//
//  MockWeatherData.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation
import WeatherKit

extension WeatherModel {
    static let loader = JSONMockLoader()
    static let decoder = JSONMockDecoder()

    static var sanFranciscoCurrentWeather: CurrentWeather? {
        let dataLoader = DataLoader<CurrentWeather>(
            loader: Self.loader,
            decoder: Self.decoder
        )

        let model = dataLoader.load(filename: "mock_san_francisco_current_weather")
        return model
    }

    static var sanFranciscoDailyForecast: Forecast<DayWeather>? {
        let dataLoader = DataLoader<Forecast<DayWeather>>(
            loader: Self.loader,
            decoder: Self.decoder
        )

        let model = dataLoader.load(filename: "mock_san_francisco_daily_weather")
        return model
    }

    static var sanFranciscoHourlyForecast: Forecast<HourWeather>? {
        let dataLoader = DataLoader<Forecast<HourWeather>>(
            loader: Self.loader,
            decoder: Self.decoder
        )

        let model = dataLoader.load(filename: "mock_san_francisco_hourly_weather")
        return model
    }

    static var weatherAttribution: WeatherAttribution? {
        let dataLoader = DataLoader<WeatherAttribution>(
            loader: Self.loader,
            decoder: Self.decoder
        )
        let model = dataLoader.load(filename: "mock_apple_weather_attribution")
        return model
    }

}
