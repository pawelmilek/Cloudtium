//
//  CurrentForecastView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 09/01/2023.
//

import SwiftUI

struct CurrentForecastView: View {
    @ObservedObject var conditionViewModel: CurrentConditionViewModel
    @ObservedObject var detailViewModel: CurrentConditionDetailViewModel
    @ObservedObject var dayDurrationViewModel: DayDurationProgressViewModel

    var body: some View {
        let _ = Self._printChanges()

        VStack(spacing: 0) {
            CurrentConditionView(viewModel: conditionViewModel)
            CurrentConditionDetailView(viewModel: detailViewModel)
            DayDurationProgressView(viewModel: dayDurrationViewModel)
        }
        .padding(.horizontal, PaddingStyle.horizontal)
        .background(ColorStyle.background)
    }
}

struct CurrentForecastView_Previews: PreviewProvider {
    static let locationName = LocationModel.sanFrancisco.city
    static let current = WeatherModel.sanFranciscoCurrentWeather!
    static let daily = WeatherModel.sanFranciscoDailyForecast!
    static let sunEvents = WeatherModel.sanFranciscoDailyForecast!.forecast.first!.sun

    static let conditionViewModel = CurrentConditionViewModel(
        locationName: locationName,
        current: current,
        daily: daily
    )
    static let detailViewModel = CurrentConditionDetailViewModel(
        humidity: current.humidity,
        pressureMeasurement: current.pressure,
        speedMeasurement: current.wind.speed
    )
    static let dayDurrationViewModel = DayDurationProgressViewModel(
        sunriseDate: sunEvents.sunrise!,
        sunsetDate: sunEvents.sunset!
    )

    static var previews: some View {
        CurrentForecastView(
            conditionViewModel: conditionViewModel,
            detailViewModel: detailViewModel,
            dayDurrationViewModel: dayDurrationViewModel
        )
        .previewLayout(.sizeThatFits)
    }
}
