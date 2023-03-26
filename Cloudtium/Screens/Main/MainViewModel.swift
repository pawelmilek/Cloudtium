//
//  MainViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/3/23.
//

import SwiftUI
import CoreLocation
import WeatherKit

@MainActor
final class MainViewModel: ObservableObject {
    @Published var selectedTab = MainTabType.home
    @Published var isLoading = true
    @Published var showError = false
    @Published var homeViewModel: HomeViewModel?
    @Published var settingsViewModel: SettingsViewModel?
    @Published var favoriteViewModel: FavoriteViewModel?

    private(set) var error: ForecastError?
    private var locationModel: LocationModel?
    private let weatherModel: WeatherModel

    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }

    func load(for location: CLLocation) async {
        isLoading = true

        do {
            error = nil
            showError = false

            let placemark = try await requestPlacemark(for: location)
            locationModel = LocationModel(placemark: placemark)
            await loadWeatherForecast()

        } catch ForecastError.placemarkUnavailable {
            self.error = .placemarkUnavailable
            showError = true
            isLoading = false

        } catch {
            self.error = .other
            showError = true
            isLoading = false
        }
    }

    private func requestPlacemark(for location: CLLocation) async throws -> CLPlacemark {
        guard let placemark = try await CLGeocoder().reverseGeocodeLocation(location).first else {
            throw ForecastError.placemarkUnavailable
        }

        return placemark
    }

    private func loadWeatherForecast() async {
        guard let locationModel else { return }
        defer { isLoading = false }

        async let current = weatherModel.weather(for: locationModel)
        async let daily = weatherModel.dailyForecast(for: locationModel)
        async let hourly = weatherModel.hourlyForecast(for: locationModel)
        async let attribution = weatherModel.attribution()

        let data = await (current: current, daily: daily, hourly: hourly, attribution: attribution)

        initializeHomeViewModel()
        initializeFavoritesViewModel()
        initializeSettingsViewModel(
            current: data.current,
            daily: data.daily,
            attribution: data.attribution
        )
    }
}

// MARK: - Init view models
private extension MainViewModel {

    func initializeHomeViewModel() {
        guard let locationModel else { return }
        homeViewModel = HomeViewModel(location: locationModel, weatherModel: weatherModel)
    }

    func initializeFavoritesViewModel() {
        favoriteViewModel = FavoriteViewModel()
    }

    func initializeSettingsViewModel(
        current: CurrentWeather?,
        daily: Forecast<DayWeather>?,
        attribution: WeatherAttribution?
    ) {
        if let locationModel, let current,
           let noonEvents = daily?.forecast.first?.moon,
           let weatherAttribution = attribution {
            settingsViewModel = SettingsViewModel(
                location: locationModel,
                currentWeather: current,
                moonPhase: noonEvents.phase,
                weatherAttribution: weatherAttribution
            )
        }
    }
}
