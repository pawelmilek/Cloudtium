//
//  LucidApp.swift
//  Lucid
//
//  Created by Pawel Milek on 03/12/2022.
//

import SwiftUI

@main
struct LucidApp: App {
  @ObservedObject private var locationManager = LocationManager()
  @ObservedObject private var weatherModel = WeatherModel()

  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(locationManager)
        .environmentObject(weatherModel)
    }
  }
}
