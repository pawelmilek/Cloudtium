//
//  WeatherForecastView.swift
//  Lucid
//
//  Created by Pawel Milek on 02/01/2023.
//

import SwiftUI
import WeatherKit

struct HomeView: View {
  @StateObject var viewModel: HomeViewModel

  var body: some View {
    List {
      Group {
        if let currentSunEvents = viewModel.currentSunEvents {
          CurrentForecastView(placeName: viewModel.city,
                              currentWeather: viewModel.currentWeather,
                              sunEvents: currentSunEvents)
          HourlyForecastChartView(viewModel: HourlyForecastChartViewModel(forecast: viewModel.hourlyForecast))
          DailyForecastView(viewModel: DailyForecastViewModel(forecast: viewModel.dailyForecast))
        }
      }
      .listRowSeparator(.hidden)
      .listRowBackground(ColorStyle.background)
    }
    .background(ColorStyle.background)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .listStyle(.plain)
    .refreshable {
      debugPrint("HomeView - Refreshing...")
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static let viewModel = HomeViewModel(place: Place.sanFrancisco,
                                       currentWeather: WeatherModel.sanFranciscoCurrentWeather!,
                                       dailyForecast: WeatherModel.sanFranciscoDailyForecast!,
                                       hourlyForecast: WeatherModel.sanFranciscoHourlyForecast!)

  static var previews: some View {
    HomeView(viewModel: viewModel)
  }
}
