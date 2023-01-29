//
//  HomeViewModel.swift
//  Lucid
//
//  Created by Pawel Milek on 15/01/2023.
//

import SwiftUI
import WeatherKit

class HomeViewModel: ObservableObject {
  @Published private(set) var city: String
  @Published private(set) var currentWeather: CurrentWeather
  @Published private(set) var dailyForecast: Forecast<DayWeather>
  @Published private(set) var hourlyForecast: Forecast<HourWeather>
  @Published private(set) var currentSunEvents: SunEvents?

  init(place: Place,
       currentWeather: CurrentWeather,
       dailyForecast: Forecast<DayWeather>,
       hourlyForecast: Forecast<HourWeather>) {
    self.city = place.city
    self.currentWeather = currentWeather
    self.dailyForecast = dailyForecast
    self.hourlyForecast = hourlyForecast

    let forecast = dailyForecast.forecast
    let nowFormatted = Date.now.formatted(date: .abbreviated, time: .omitted)
    let currentForecast = forecast.first(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == nowFormatted })
    self.currentSunEvents = currentForecast?.sun
  }
}
