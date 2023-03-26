//
//  DayDurationProgressViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation
import WeatherKit

final class DayDurationProgressViewModel: ObservableObject {
    @Published var sunrise = ""
    @Published var sunset = ""
    @Published var dayTimeLeftDescription = ""

    var maximumValueInMinutes: Double {
        let result = calculateTotalMinutesFromSunriseToSunset()
        return Double(result)
    }
    var minutesFromSunriseToNow: Double {
        let result = Double(calculateMinutesFromSunriseToNow())

        if result > maximumValueInMinutes {
            return maximumValueInMinutes
        } else {
            return result
        }
    }

    let daySymbol = "sun.max.circle.fill"
    let nightSymbol = "moonphase.waning.gibbous.inverse"

    private let sunriseDate: Date
    private let sunsetDate: Date

    init(sunriseDate: Date, sunsetDate: Date) {
        self.sunriseDate = sunriseDate
        self.sunsetDate = sunsetDate
        sunrise = sunriseDate.formatted(date: .omitted, time: .shortened)
        sunset = sunsetDate.formatted(date: .omitted, time: .shortened)
        dayTimeLeftDescription = leftHoursMinutesInDayFormatted
    }

    private var leftHoursMinutesInDayFormatted: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.pad]

        let minutes = Measurement(value: leftMinutesInDay, unit: UnitDuration.minutes)
        let leftSecondsInDay = minutes.converted(to: .seconds)
        let result = formatter.string(from: leftSecondsInDay.value)
        return result ?? ""
    }

    private var leftMinutesInDay: Double {
        let minutesFromSunriseToNow = Double(calculateMinutesFromSunriseToNow())
        return max(maximumValueInMinutes - minutesFromSunriseToNow, 0)
    }

    private func calculateTotalMinutesFromSunriseToSunset() -> UInt {
        let dateComponents = Calendar.current.dateComponents([.minute], from: sunriseDate, to: sunsetDate)
        return UInt(dateComponents.minute ?? 0)
    }

    private func calculateMinutesFromSunriseToNow() -> UInt {
        let dateComponents = Calendar.current.dateComponents([.minute], from: sunriseDate, to: Date.now)
        return UInt(max(dateComponents.minute ?? 0, 0))
    }
}
