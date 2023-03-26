//
//  CloudtiumApp.swift
//  Cloudtium
//
//  Created by Pawel Milek on 03/12/2022.
//

import SwiftUI

@main
struct CloudtiumApp: App {
    @StateObject private var settingsStorage = SettingsStorage.shared
    @StateObject private var stateManager = ApplicationStateManager()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var mainViewModel = MainViewModel(weatherModel: WeatherModel())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateManager)
                .environmentObject(locationManager)
                .environmentObject(onboardingViewModel)
                .environmentObject(mainViewModel)
                .environmentObject(settingsStorage)
        }
    }
}
