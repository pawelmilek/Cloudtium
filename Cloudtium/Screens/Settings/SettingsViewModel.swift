//
//  SettingsViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

// swiftlint:disable force_cast
import Foundation
import WeatherKit
import SwiftUI
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var locationDescription = ""
    @Published var detailViewModel: CurrentConditionDetailViewModel
    @Published var temperature = ""
    @Published var moonphaseDescription: String
    @Published var moonphaseSymbol: String
    @Published var attribution: (link: URL, logo: URL)
    @Published var temperatureCheckmarkIndex = 0
    @Published var speedCheckmarkIndex = 0

    let listProviderTemperature = SelectionListDataSourceGenerator.listProviderTemperature()
    let listProviderSpeed = SelectionListDataSourceGenerator.listProviderSpeed()

    private let defaultTemperatureUnit: UnitTemperature
    private var defaultTemperatureValue: Double
    private let settingsStorage: SettingsStorage
    private var cancellables = Set<AnyCancellable>()

    init(
        location: LocationModel,
        currentWeather: CurrentWeather,
        moonPhase: MoonPhase,
        weatherAttribution: WeatherAttribution,
        settingsStorage: SettingsStorage = .shared
    ) {
        let current = Locale.autoupdatingCurrent
        let countryName = current.localizedString(forRegionCode: location.countryCode) ?? location.countryCode
        locationDescription = "\(location.city), \(countryName)"
        moonphaseDescription = moonPhase.description
        moonphaseSymbol = moonPhase.symbolName
        detailViewModel = CurrentConditionDetailViewModel(
            humidity: currentWeather.humidity,
            pressureMeasurement: currentWeather.pressure,
            speedMeasurement: currentWeather.wind.speed
        )

        defaultTemperatureUnit = currentWeather.temperature.unit
        defaultTemperatureValue = currentWeather.temperature.value
        attribution = (weatherAttribution.legalPageURL, weatherAttribution.combinedMarkLightURL)
        self.settingsStorage = settingsStorage

        loadSavedSettings()
        setupSubscribers()
    }

    private func loadSavedSettings() {
        temperatureCheckmarkIndex = listProviderTemperature.items
            .first { $0.unit.symbol == settingsStorage.temperatureSymbol }?.index ?? 0
        speedCheckmarkIndex = listProviderSpeed.items
            .first { $0.unit.symbol == settingsStorage.speedSymbol }?.index ?? 0
    }

    private func setupSubscribers() {
        $temperatureCheckmarkIndex
            .sink { [self] newValue in
                guard let selected = listProviderTemperature.item(at: newValue) else { return }
                settingsStorage.temperatureSymbol = selected.unit.symbol

                let selectedUnit = selected.unit
                if selectedUnit != defaultTemperatureUnit {
                    let fromUnit = defaultTemperatureUnit
                    let toUnit = selected.unit as! UnitTemperature
                    let result = convertedTemperatureValue(from: fromUnit, to: toUnit)
                    temperature = "\(Int(result))º"

                } else {
                    temperature = "\(Int(defaultTemperatureValue))º"
                }
            }
            .store(in: &cancellables)

        $speedCheckmarkIndex
            .sink { [self] newValue in
                guard let selected = listProviderSpeed.item(at: newValue) else { return }
                settingsStorage.speedSymbol = selected.unit.symbol
            }
            .store(in: &cancellables)
    }

    private func convertedTemperatureValue(from: UnitTemperature, to: UnitTemperature) -> Double {
        let converter = MeasurementUnitConverter(value: defaultTemperatureValue)
        return converter.convertedTemperature(from: from, to: to).value
    }
}
