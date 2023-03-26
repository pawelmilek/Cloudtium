//
//  WeatherServiceable.swift
//  Cloudtium
//
//  Created by Pawel Milek on 10/12/2022.
//

import Foundation
import WeatherKit

protocol WeatherServiceable {
  func weather(for place: LocationModel) async -> CurrentWeather?
  func dailyForecast(for place: LocationModel) async -> Forecast<DayWeather>?
  func hourlyForecast(for place: LocationModel) async -> Forecast<HourWeather>?
  func attribution() async -> WeatherAttribution?
}
