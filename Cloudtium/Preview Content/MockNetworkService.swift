//
//  MockNetworkService.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation
import WeatherKit

struct MockNetworkService: WeatherServiceable {

    func weather(for place: LocationModel) async -> CurrentWeather? {
        await WeatherModel.sanFranciscoCurrentWeather
    }

    func dailyForecast(for place: LocationModel) async -> Forecast<DayWeather>? {
        await WeatherModel.sanFranciscoDailyForecast
    }

    func hourlyForecast(for place: LocationModel) async -> Forecast<HourWeather>? {
        await WeatherModel.sanFranciscoHourlyForecast
    }

    func attribution() async -> WeatherAttribution? {
        await WeatherModel.weatherAttribution
    }
}
