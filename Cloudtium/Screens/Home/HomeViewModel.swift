//
//  HomeViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 15/01/2023.
//

import SwiftUI
import WeatherKit

@MainActor
protocol HomeViewModelProtocol: AnyObject, ObservableObject {
    var city: String { get }
    var conditionViewModel: CurrentConditionViewModel? { get }
    var detailViewModel: CurrentConditionDetailViewModel? { get }
    var dayDurrationViewModel: DayDurationProgressViewModel? { get }
    var hourlyChartViewModel: HourlyForecastChartViewModel? { get }
    var dailyViewModel: DailyForecastViewModel? { get }

    func load()
}

@MainActor
class HomeViewModel: HomeViewModelProtocol {
    @Published private(set) var city = ""
    @Published private(set) var conditionViewModel: CurrentConditionViewModel?
    @Published private(set) var detailViewModel: CurrentConditionDetailViewModel?
    @Published private(set) var dayDurrationViewModel: DayDurationProgressViewModel?
    @Published private(set) var hourlyChartViewModel: HourlyForecastChartViewModel?
    @Published private(set) var dailyViewModel: DailyForecastViewModel?

    private var currentWeather: CurrentWeather?
    private var dailyForecast: Forecast<DayWeather>?
    private var hourlyForecast: Forecast<HourWeather>?
    private var sunEvents: SunEvents?

    init(location: LocationModel, weatherModel: WeatherModel) {
        city = location.city
        currentWeather = weatherModel[location: location.id]
        dailyForecast = weatherModel[location: location.id]
        hourlyForecast = weatherModel[location: location.id]
        sunEvents = solarEventsForCurrentDate()
    }

    func load() {
        if let current = currentWeather,
           let daily = dailyForecast,
           let hourly = hourlyForecast,
           let sunriseDate = sunEvents?.sunrise,
           let sunsetDate = sunEvents?.sunset {
            conditionViewModel = CurrentConditionViewModel(
                locationName: city,
                current: current,
                daily: daily
            )
            detailViewModel = CurrentConditionDetailViewModel(
                humidity: current.humidity,
                pressureMeasurement: current.pressure,
                speedMeasurement: current.wind.speed
            )
            dayDurrationViewModel = DayDurationProgressViewModel(sunriseDate: sunriseDate, sunsetDate: sunsetDate)
            hourlyChartViewModel = HourlyForecastChartViewModel(forecast: hourly)
            dailyViewModel = DailyForecastViewModel(currentWeather: current, dailyWeather: daily)

        } else {
            conditionViewModel = nil
            detailViewModel = nil
            dayDurrationViewModel = nil
            hourlyChartViewModel = nil
            dailyViewModel = nil
        }
    }
}

// MARK: - Private - Helper methods
private extension HomeViewModel {

    func solarEventsForCurrentDate() -> SunEvents? {
        guard let days = dailyForecast?.forecast else { return nil }

        let nowFormatted = Date.now.formatted(date: .abbreviated, time: .omitted)
        let today = days.first(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == nowFormatted })
        let sun = today?.sun
        return sun
    }
}
