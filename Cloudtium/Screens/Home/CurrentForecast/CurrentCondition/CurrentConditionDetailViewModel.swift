//
//  CurrentConditionDetailViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/8/23.
//

import Foundation
import WeatherKit

@MainActor
final class CurrentConditionDetailViewModel: ObservableObject {
    @Published var humidity = "init value"
    @Published var pressure = "init value"
    @Published var speed = "init value"

    let humiditySymbol = "drop"
    let pressureSymbol = "rectangle.compress.vertical"
    let windSymbol = "wind"

    private let humidityValue: Double
    private let pressureMeasurement: Measurement<UnitPressure>
    private let speedMeasurement: Measurement<UnitSpeed>
    private var defaultSpeedValue: Double
    private let defaultUnitSpeed: UnitSpeed
    private let settings: SettingsStorage

    init(
        humidity: Double,
        pressureMeasurement: Measurement<UnitPressure>,
        speedMeasurement: Measurement<UnitSpeed>,
        settings: SettingsStorage = .shared
    ) {
        print("CurrentConditionDetailViewModel init")
        self.humidityValue = humidity
        self.pressureMeasurement = pressureMeasurement
        self.speedMeasurement = speedMeasurement
        self.defaultSpeedValue = speedMeasurement.value
        self.defaultUnitSpeed = speedMeasurement.unit
        self.settings = settings
    }

    func load() {
        humidity = "\(Int(humidityValue * 100).formatted(.percent))"
        pressure = pressureMeasurement.formatted()

        let selectedUnitSpeed = (try? UnitSpeed.make(by: settings.speedSymbol)) ?? defaultUnitSpeed
        let hasUnitChanged = (defaultUnitSpeed != selectedUnitSpeed)
        let result: Double

        if hasUnitChanged {
            result = convertedSpeedValue(from: defaultUnitSpeed, to: selectedUnitSpeed)
        } else {
            result = defaultSpeedValue
        }
        speed = "\(Int(result)) \(selectedUnitSpeed.symbol)"
        print("CurrentConditionDetailViewModel load - \(speed)")
    }

    private func convertedSpeedValue(from: UnitSpeed, to: UnitSpeed) -> Double {
        let converter = MeasurementUnitConverter(value: defaultSpeedValue)
        return converter.convertedSpeed(from: from, to: to).value
    }
}
