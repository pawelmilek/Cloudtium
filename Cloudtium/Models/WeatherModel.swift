//
//  WeatherModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation
import WeatherKit
import os

@MainActor
class WeatherModel: ObservableObject {
  let logger = Logger(subsystem: "milek.pawel.cloudtium.WeatherModel", category: "Model")

  @Published private var _currentWeathers = [LocationModel.ID: CurrentWeather]()
  @Published private var _dailyForecasts = [LocationModel.ID: Forecast<DayWeather>]()
  @Published private var _hourlyForecasts = [LocationModel.ID: Forecast<HourWeather>]()
  @Published private(set) var attribution: WeatherAttribution?

  private let service: WeatherServiceable

  init(service: WeatherServiceable = NetworkService()) {
    self.service = service
  }

  subscript(location id: LocationModel.ID) -> CurrentWeather? {
    _currentWeathers[id]
  }

  subscript(location id: LocationModel.ID) -> Forecast<DayWeather>? {
    _dailyForecasts[id]
  }

  subscript(location id: LocationModel.ID) -> Forecast<HourWeather>? {
    _hourlyForecasts[id]
  }

  @discardableResult
  func weather(for location: LocationModel) async -> CurrentWeather? {
    let currentWeather = await service.weather(for: location)
    _currentWeathers[location.id] = currentWeather
    return currentWeather
  }

  @discardableResult
  func dailyForecast(for location: LocationModel) async -> Forecast<DayWeather>? {
    let dayWeather = await service.dailyForecast(for: location)
    _dailyForecasts[location.id] = dayWeather
    return dayWeather
  }

  @discardableResult
  func hourlyForecast(for location: LocationModel) async -> Forecast<HourWeather>? {
    let hourWeather = await service.hourlyForecast(for: location)
    _hourlyForecasts[location.id] = hourWeather
    return hourWeather
  }

  @discardableResult
  func attribution() async -> WeatherAttribution? {
    let result = await service.attribution()
    attribution = result
    return result
  }

}
