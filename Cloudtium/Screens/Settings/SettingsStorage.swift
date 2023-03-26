//
//  SettingsStorage.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/29/23.
//

import Foundation
import SwiftUI

final class SettingsStorage: ObservableObject {
    static let shared = SettingsStorage()

    @AppStorage(Constants.favoriteTemperatureUnit) var temperatureSymbol: String = ""
    @AppStorage(Constants.favoriteSpeedUnit) var speedSymbol: String = ""

    private enum Constants {
        static let favoriteTemperatureUnit = "favoriteTemperatureUnit"
        static let favoriteSpeedUnit = "favoriteSpeedUnit"
    }

    private var defaultTemperatureSymbol: String {
        switch Locale.autoupdatingCurrent.measurementSystem {
        case .metric: return UnitTemperature.celsius.symbol
        default: return UnitTemperature.fahrenheit.symbol
        }
    }

    private var defaultSpeedSymbol: String {
        switch Locale.autoupdatingCurrent.measurementSystem {
        case .metric: return UnitSpeed.kilometersPerHour.symbol
        default: return UnitSpeed.milesPerHour.symbol
        }
    }

    private init() {
        setupDefaultSettings()
    }

    private func setupDefaultSettings() {
        if temperatureSymbol.isEmpty {
            temperatureSymbol = defaultTemperatureSymbol
        }

        if speedSymbol.isEmpty {
            speedSymbol = defaultSpeedSymbol
        }
    }
}
