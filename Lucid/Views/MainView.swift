//
//  MainView.swift
//  Lucid
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct MainView: View {
  @EnvironmentObject private var locationManager: LocationManager
  @EnvironmentObject private var weatherModel: WeatherModel
  @State private var place: Place?
  @State private var isLoading = true

  var body: some View {
    ZStack {
      ColorStyle.background.ignoresSafeArea()

      if isLoading {
        ProgressView()
      } else {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
          LocationRequestView().environmentObject(locationManager)

        case .authorizedAlways, .authorizedWhenInUse:
          TabView {
            Group {
              if let place,
                 let currentWeather = weatherModel[place: place.id] as CurrentWeather?,
                 let dailyForecast = weatherModel[place: place.id] as Forecast<DayWeather>?,
                 let hourlyForecast = weatherModel[place: place.id] as Forecast<HourWeather>? {
                HomeView(viewModel: HomeViewModel(place: place,
                                                  currentWeather: currentWeather,
                                                  dailyForecast: dailyForecast,
                                                  hourlyForecast: hourlyForecast))
              } else {
                EmptyView()
              }
            }
            .tabItem {
              Label("", systemImage: "house")
            }

            FavoriteView()
              .tabItem {
                Label("", systemImage: "suit.heart")
              }

            if let place,
               let currentWeather = weatherModel[place: place.id] as CurrentWeather?,
               let dailyForecast = weatherModel[place: place.id] as Forecast<DayWeather>?,
               let moonEvents = dailyForecast.forecast.first?.moon,
               let attribution = weatherModel.attribution {
              SettingsView(placeName: place.locationDescription,
                           currentWeather: currentWeather,
                           moon: moonEvents,
                           attribution: attribution)
                .tabItem {
                  Label("", systemImage: "slider.horizontal.3")
                }
            }
          }
          .accentColor(ColorStyle.accent)

        @unknown default:
          fatalError()
        }
      }
    }
    .task(id: locationManager.placemark) {
      if let placemark = locationManager.placemark {
        place = Place(placemark: placemark)
        await loadData(for: place!)
      }
    }
  }

  private func loadData(for place: Place) async {
    async let current = weatherModel.weather(for: place)
    async let daily = weatherModel.dailyForecast(for: place)
    async let hourly = weatherModel.hourlyForecast(for: place)
    async let attribution = weatherModel.attribution()

    let _ = await (current, daily, hourly, attribution)
    isLoading = false
  }
}

struct MainView_Previews: PreviewProvider {
  @ObservedObject static var locationManager = LocationManager()

  static var previews: some View {
    MainView()
      .environmentObject(locationManager)
      .environmentObject(WeatherModel())
  }
}
