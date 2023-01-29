//
//  WeatherModel.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation
import WeatherKit
import os

@MainActor
class WeatherModel: ObservableObject {
  let logger = Logger(subsystem: "milek.pawel.Lucid.WeatherModel", category: "Model")
  @Published private var _currentWeathers = [Place.ID: CurrentWeather]()
  @Published private var _dailyForecasts = [Place.ID: Forecast<DayWeather>]()
  @Published private var _hourlyForecasts = [Place.ID: Forecast<HourWeather>]()
  @Published private(set) var attribution: WeatherAttribution?

  private let service: WeatherServiceable

  init(service: WeatherServiceable = NetworkService()) {
    self.service = service
  }
  
  subscript(place id: Place.ID) -> CurrentWeather? {
    _currentWeathers[id]
  }

  subscript(place id: Place.ID) -> Forecast<DayWeather>? {
    _dailyForecasts[id]
  }

  subscript(place id: Place.ID) -> Forecast<HourWeather>? {
    _hourlyForecasts[id]
  }

  @discardableResult
  func weather(for place: Place) async -> CurrentWeather? {
    let currentWeather = await service.weather(for: place)
    _currentWeathers[place.id] = currentWeather
    return currentWeather
  }

  @discardableResult
  func dailyForecast(for place: Place) async -> Forecast<DayWeather>? {
    let dayWeather = await service.dailyForecast(for: place)
    _dailyForecasts[place.id] = dayWeather
    return dayWeather
  }

  @discardableResult
  func hourlyForecast(for place: Place) async -> Forecast<HourWeather>? {
    let hourWeather = await service.hourlyForecast(for: place)
    _hourlyForecasts[place.id] = hourWeather
    return hourWeather
  }

  @discardableResult
  func attribution() async -> WeatherAttribution? {
    let result = await service.attribution()
    attribution = result
    return result
  }

}

// MARK: - DEBUG - Use it for Preview and mock data
#if DEBUG
extension WeatherModel {

  static var sanFranciscoCurrentWeather: CurrentWeather? {
    guard let data = JSONFileLoader(fileName: "mock_san_francisco_current_weather").load() else { return nil }

    let result = DataDecoder<CurrentWeather>.decode(data)
    switch result {
    case .success(let model):
      return model

    case .failure(let error):
      debugPrint(error)
      return nil
    }
  }

  static var sanFranciscoDailyForecast: Forecast<DayWeather>? {
    guard let data = JSONFileLoader(fileName: "mock_san_francisco_daily_weather").load() else { return nil }

    let result = DataDecoder<Forecast<DayWeather>>.decode(data)
    switch result {
    case .success(let model):
      return model

    case .failure(let error):
      debugPrint(error)
      return nil
    }
  }

  static var sanFranciscoHourlyForecast: Forecast<HourWeather>? {
    guard let data = JSONFileLoader(fileName: "mock_san_francisco_hourly_weather").load() else { return nil }

    let result = DataDecoder<Forecast<HourWeather>>.decode(data)
    switch result {
    case .success(let model):
      return model

    case .failure(let error):
      debugPrint(error)
      return nil
    }
  }

  static var weatherAttribution: WeatherAttribution? {
    guard let data = JSONFileLoader(fileName: "mock_apple_weather_attribution").load() else { return nil }

    let result = DataDecoder<WeatherAttribution>.decode(data)
    switch result {
    case .success(let model):
      return model

    case .failure(let error):
      debugPrint(error)
      return nil
    }
  }
  
}
#endif

extension Encodable {
    /// Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> NSString {
        let data = try encoder.encode(self)
        let result = String(decoding: data, as: UTF8.self)
        return NSString(string: result)
    }
}
