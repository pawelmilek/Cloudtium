//
//  DailyForecastView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI
import WeatherKit

struct DailyForecastView: View {
    var viewModel: DailyForecastViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.callout)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundColor(ColorStyle.textLight)

            ForEach(viewModel.tenDaysForecast, id: \.date) { item in
                HStack(spacing: 15) {
                    Text(viewModel.day(item))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .foregroundColor(ColorStyle.text)
                        .frame(maxWidth: 90, alignment: .leading)
                    Image(systemName: item.symbolName)
                        .imagePaletteModifier()
                        .frame(width: 25)
                    TemperatureBarRow(data: viewModel.temperatureBarData(item))
//                    HStack(spacing: 15) {
//                        Text(item.lowTemperature.formatted(Style.narrowTemperatureStyle))
//                            .foregroundColor(ColorStyle.textLight)
//                        Text(item.highTemperature.formatted(Style.narrowTemperatureStyle))
//                            .foregroundColor(ColorStyle.text)
//                    }
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .fontDesign(.rounded)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding(.horizontal, PaddingStyle.horizontal)
        .background(ColorStyle.background)
        .foregroundColor(ColorStyle.text)
    }
}

// swiftlint:disable type_name
struct DailyForecastView_Preview: PreviewProvider {
    static let current = WeatherModel.sanFranciscoCurrentWeather!
    static let dailyForecast = WeatherModel.sanFranciscoDailyForecast!
    static let viewModel = DailyForecastViewModel(currentWeather: current, dailyWeather: dailyForecast)

    static var previews: some View {
        DailyForecastView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
