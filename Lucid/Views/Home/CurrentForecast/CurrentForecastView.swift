//
//  CurrentForecastView.swift
//  Lucid
//
//  Created by Pawel Milek on 09/01/2023.
//

import SwiftUI
import WeatherKit

struct CurrentForecastView: View {
  var placeName: String
  var currentWeather: CurrentWeather
  var sunEvents: SunEvents

  var body: some View {
    VStack {
      CurrentConditionView(placeName: placeName,
                           symbolName: currentWeather.symbolName,
                           temperature: currentWeather.temperature,
                           shortConditionDescription: currentWeather.condition.description)
      
      CurrentConditionDetailsView(humidity: currentWeather.humidity,
                                  pressure: currentWeather.pressure,
                                  windSpeed: currentWeather.wind.speed)

      if let sunrise = sunEvents.sunrise, let sunset = sunEvents.sunset {
        DayDurationProgressView(sunrise: sunrise, sunset: sunset)
      }
    }
    .padding(.horizontal, 5)
    .background(ColorStyle.background)
  }

  @MainActor
  private func mockSunState() -> SunEvents {
    let sunState = WeatherModel.sanFranciscoDailyForecast!.forecast
      .first(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted) })!.sun

    return sunState
  }
}

struct CurrentForecastView_Previews: PreviewProvider {
  private static let palce = Place.sanFrancisco
  private static let current = WeatherModel.sanFranciscoCurrentWeather!
  private static let sunEvents = WeatherModel.sanFranciscoDailyForecast!.forecast
    .first(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted) })!.sun

  static var previews: some View {
    CurrentForecastView(placeName: palce.city, currentWeather: current, sunEvents: sunEvents)
      .previewLayout(.sizeThatFits)
  }
}
