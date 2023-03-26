//
//  MockHomeViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation
import WeatherKit

final class MockHomeViewModel: HomeViewModelProtocol {
    @Published var city: String = ""
    @Published var conditionViewModel: CurrentConditionViewModel?
    @Published var detailViewModel: CurrentConditionDetailViewModel?
    @Published var dayDurrationViewModel: DayDurationProgressViewModel?
    @Published var hourlyChartViewModel: HourlyForecastChartViewModel?
    @Published var dailyViewModel: DailyForecastViewModel?

    let currentWeather = WeatherModel.sanFranciscoCurrentWeather!
    let dailyForecast = WeatherModel.sanFranciscoDailyForecast!
    let hourlyForecast = WeatherModel.sanFranciscoHourlyForecast!
    let sunEvents = WeatherModel.sanFranciscoDailyForecast!.forecast.first!.sun

    func load() {
        city = LocationModel.sanFrancisco.city
        conditionViewModel = CurrentConditionViewModel(
            locationName: city,
            current: currentWeather,
            daily: dailyForecast
        )
        detailViewModel = CurrentConditionDetailViewModel(
            humidity: currentWeather.humidity,
            pressureMeasurement: currentWeather.pressure,
            speedMeasurement: currentWeather.wind.speed
        )
        dayDurrationViewModel = DayDurationProgressViewModel(
            sunriseDate: sunEvents.sunrise!,
            sunsetDate: sunEvents.sunset!
        )
        hourlyChartViewModel = HourlyForecastChartViewModel(forecast: hourlyForecast)
        dailyViewModel = DailyForecastViewModel(
            currentWeather: currentWeather,
            dailyWeather: dailyForecast
        )
    }
}
