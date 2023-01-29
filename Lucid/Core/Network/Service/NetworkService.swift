//
//  WeatherService.swift
//  Lucid
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

  func weather(for place: Place) async -> CurrentWeather? {
    let currentWeather = await Task.detached(priority: .userInitiated) {
      let forecast = try? await self.service.weather(for: place.location, including: .current)
      return forecast
    }.value

    return currentWeather
  }

  func dailyForecast(for place: Place) async -> Forecast<DayWeather>? {
    let dayWeather = await Task.detached(priority: .userInitiated) {
      let forecast = try? await self.service.weather(for: place.location, including: .daily)
      return forecast
    }.value

    return dayWeather
  }

  func hourlyForecast(for place: Place) async -> Forecast<HourWeather>? {
    let hourWeather = await Task.detached(priority: .userInitiated) {
      let forecast = try? await self.service.weather(for: place.location, including: .hourly)
      return forecast
    }.value

    return hourWeather
  }

  func attribution() async -> WeatherAttribution? {
    let attribution = await Task.detached(priority: .userInitiated) {
      let result = try? await self.service.attribution
      return result
    }.value

    return attribution
  }
  
}
