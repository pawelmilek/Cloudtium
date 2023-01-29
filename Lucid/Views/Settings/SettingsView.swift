//
//  SettingsView.swift
//  Lucid
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI
import WeatherKit

struct User: Identifiable {
    let id: Int
    var name: String
    var score: Int
}

struct SettingsView: View {
  @Environment(\.colorScheme) var colorScheme
  var placeName: String
  var currentWeather: CurrentWeather
  var moon: MoonEvents
  var attribution: WeatherAttribution

  @State private var users = [
      User(id: 1, name: "Taylor Swift", score: 95),
      User(id: 2, name: "Justin Bieber", score: 80),
      User(id: 3, name: "Adele Adkins", score: 85)
  ]

  var body: some View {
    ZStack {
      ColorStyle.background.ignoresSafeArea()

      VStack(spacing: 15) {
        YourLocationView(placeName: placeName)
        Image(systemName: "moonphase.full.moon.inverse")
          .resizable()
          .frame(width: 150, height: 150, alignment: .center)
          .foregroundStyle(
            LinearGradient(
              colors: [ColorStyle.primary, ColorStyle.secondary],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
          .shadow(color: ColorStyle.primary, radius: 38, x: 0, y: 0)
          .padding()

        Text(moon.phase.description)
          .font(.subheadline)
          .fontWeight(.medium)
          .foregroundColor(ColorStyle.text)
          .lineLimit(1)
          .frame(height: 33)
          .padding(.horizontal, 20)
          .background(ColorStyle.capsule)
          .clipShape(Capsule())

        Text(currentWeather.temperature.formatted(Style.narrowTemperatureStyle))
          .font(.system(size: 72))
          .lineLimit(1)
          .foregroundColor(ColorStyle.text)

        CurrentConditionDetailsView(humidity: currentWeather.humidity,
                                    pressure: currentWeather.pressure,
                                    windSpeed: currentWeather.wind.speed)
        .padding(.horizontal, 60)
        .padding(.bottom, 25)

        VStack(alignment: .leading, spacing: 25) {
          HStack {
            Text("Temperature")
            Spacer()
            Text(currentWeather.temperature.unit.symbol)
              .foregroundColor(ColorStyle.condition)
              .padding(.horizontal, 5)
            Image(systemName: "chevron.forward")
              .resizable()
              .frame(width: 5, height: 10, alignment: .center)
          }
          HStack {
            Text("Wind Speed")
            Spacer()
            Text(currentWeather.wind.speed.unit.symbol)
              .foregroundColor(ColorStyle.condition)
              .padding(.horizontal, 5)
            Image(systemName: "chevron.forward")
              .resizable()
              .frame(width: 5, height: 10, alignment: .center)
          }
          HStack {
            Text("Source")
            Spacer()
            let colorSchemed = colorSchemedLinkLogo(by: attribution)
            AttributionFooterView(logo: colorSchemed.logo, link: colorSchemed.link)
              .foregroundColor(ColorStyle.condition)
              .padding(.horizontal, 5)
            Image(systemName: "chevron.forward")
              .resizable()
              .frame(width: 5, height: 10, alignment: .center)
          }
        }
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundColor(ColorStyle.text)
        .padding(.horizontal, 25)
        Spacer()
      }
    }

  }

  private func colorSchemedLinkLogo(by attribution: WeatherAttribution) -> (link: URL, logo: URL) {
    let link = attribution.legalPageURL
    let logo = colorScheme == .light ? attribution.combinedMarkLightURL : attribution.combinedMarkDarkURL
    return (link, logo)
  }
}

struct SettingsView_Previews: PreviewProvider {
  @ObservedObject static var locationManager = LocationManager()
  private static let current = WeatherModel.sanFranciscoCurrentWeather!
  private static let moon = WeatherModel.sanFranciscoDailyForecast!.forecast.first!.moon
  private static let weatherAttribution = WeatherModel.weatherAttribution!


  static var previews: some View {
    SettingsView(placeName: Place.sanFrancisco.locationDescription,
                 currentWeather: current,
                 moon: moon,
                 attribution: weatherAttribution)
      .environmentObject(WeatherModel())
  }
}
