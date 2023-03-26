//
//  Dimension+Factory.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/7/23.
//

import Foundation

extension UnitTemperature {

    static func make(by symbol: String) throws -> UnitTemperature {
        switch symbol {
        case UnitTemperature.celsius.symbol:
            return UnitTemperature.celsius

        case UnitTemperature.fahrenheit.symbol:
            return UnitTemperature.fahrenheit

        case UnitTemperature.kelvin.symbol:
            return UnitTemperature.kelvin

        default:
            throw CocoaError(.featureUnsupported)
        }
    }

}

extension UnitSpeed {

    static func make(by symbol: String) throws -> UnitSpeed {
        switch symbol {
        case UnitSpeed.kilometersPerHour.symbol:
            return UnitSpeed.kilometersPerHour

        case UnitSpeed.milesPerHour.symbol:
            return UnitSpeed.milesPerHour

        case UnitSpeed.metersPerSecond.symbol:
            return UnitSpeed.metersPerSecond

        default:
            throw CocoaError(.featureUnsupported)
        }
    }

}
