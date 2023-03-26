//
//  MeasurementUnitConverter.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/7/23.
//

import Foundation

struct MeasurementUnitConverter {
    private let value: Double

    init(value: Double) {
        self.value = value
    }

    func convertedSpeed(from: UnitSpeed, to: UnitSpeed) -> Measurement<UnitSpeed> {
        let measurement = Measurement<UnitSpeed>(value: value, unit: from)

        switch to {
        case UnitSpeed.kilometersPerHour:
            return measurement.converted(to: .kilometersPerHour)

        case UnitSpeed.milesPerHour:
            return measurement.converted(to: .milesPerHour)

        default:
            fatalError("Unsupported speed unit \(to)")
        }
    }

    func convertedTemperature(from: UnitTemperature, to: UnitTemperature) -> Measurement<UnitTemperature> {
        let measurement = Measurement(value: value, unit: from)

        switch to {
        case .celsius:
            return measurement.converted(to: .celsius)

        case .fahrenheit:
            return measurement.converted(to: .fahrenheit)

        default:
            fatalError("Unsupported temperature unit \(to)")
        }
    }
}
