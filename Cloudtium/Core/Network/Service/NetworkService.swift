//
//  WeatherService.swift
//  Cloudtium
//
//  Created by Pawel Milek on 03/12/2022.
//

import Foundation
import WeatherKit
import CoreLocation

struct NetworkService: WeatherServiceable {
    private let service: WeatherService

    init(service: WeatherService = WeatherService.shared) {
        self.service = service
    }

    func weather(for place: LocationModel) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(for: place.location, including: .current)
            return forecast
        }.value

        debugPrettyPrint(currentWeather)
        return currentWeather
    }

    func dailyForecast(for place: LocationModel) async -> Forecast<DayWeather>? {
        let dayWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(for: place.location, including: .daily)
            return forecast
        }.value

        debugPrettyPrint(dayWeather)
        return dayWeather
    }

    func hourlyForecast(for place: LocationModel) async -> Forecast<HourWeather>? {
        let hourWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(for: place.location, including: .hourly)
            return forecast
        }.value

        debugPrettyPrint(hourWeather)
        return hourWeather
    }

    func attribution() async -> WeatherAttribution? {
        let attribution = await Task.detached(priority: .userInitiated) {
            let result = try? await self.service.attribution
            return result
        }.value

        debugPrettyPrint(attribution)
        return attribution
    }

}

// MARK: - Print JSON response
private extension NetworkService {

    func debugPrettyPrint<T>(_ data: T) where T: Encodable {
#if DEBUG
//        JSONEncoder.prettyPrint(data)
#endif
    }
}
