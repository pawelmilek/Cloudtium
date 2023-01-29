//
//  WeatherServiceable.swift
//  Lucid
//
//  Created by Pawel Milek on 10/12/2022.
//

import Foundation
import WeatherKit

protocol WeatherServiceable {
  func weather(for place: Place) async -> CurrentWeather?
  func dailyForecast(for place: Place) async -> Forecast<DayWeather>?
  func hourlyForecast(for place: Place) async -> Forecast<HourWeather>?
  func attribution() async -> WeatherAttribution?
}
