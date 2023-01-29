//
//  TenDaysForecastView.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI
import WeatherKit

struct DailyForecastView: View {
  var viewModel: DailyForecastViewModel

  var body: some View {
    VStack(alignment: .leading) {
      Text("Daily forecast")
        .font(.subheadline)
        .fontWeight(.medium)
        .lineLimit(1)
        .foregroundColor(ColorStyle.textLight)

      ForEach(viewModel.forecast, id: \.date) { item in
        HStack {
          Text(item.date.abbreviatedDay)
            .font(.footnote)
            .fontWeight(.medium)
            .scaledToFill()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .foregroundColor(ColorStyle.text)
            .frame(maxWidth: .infinity, alignment: .leading)

          Image(systemName: "\(item.symbolName)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20, alignment: .center)
            .foregroundStyle(viewModel.gradient)
            .shadow(color: ColorStyle.primary, radius: 2, x: 0, y: 0)

          HStack(spacing: 15) {
            Group {
              Text(item.highTemperature.formatted(Style.narrowTemperatureStyle))
                .foregroundColor(ColorStyle.text)
              Text(item.lowTemperature.formatted(Style.narrowTemperatureStyle))
                .foregroundColor(ColorStyle.textLight)
            }
            .font(.footnote)
            .scaledToFill()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
          }
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
      }
    }
    .padding(.horizontal, 5)
    .background(ColorStyle.background)
    .foregroundColor(ColorStyle.text)
  }
}

struct TenDaysForecastView_Preview: PreviewProvider {
  static let dailyForecast = WeatherModel.sanFranciscoDailyForecast!

  static var previews: some View {
    DailyForecastView(viewModel: DailyForecastViewModel(forecast: dailyForecast))
      .previewLayout(.sizeThatFits)
  }
}
