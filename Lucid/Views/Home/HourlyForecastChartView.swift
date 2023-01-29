//
//  HourlyForecastChartView.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI
import WeatherKit
import Charts

struct HourlyForecastChartView: View {
  var viewModel: HourlyForecastChartViewModel
  private let minYScale = 150
  private let maxYScale = 240
  private let chartWidth: CGFloat = 350
  private let chartHeight: CGFloat = 125
  private let dataPointWidth: CGFloat = 65

  var body: some View {
    VStack(alignment: .leading) {
      Text("Hourly forecast")
        .font(.subheadline)
        .fontWeight(.medium)
        .lineLimit(1)
        .foregroundColor(ColorStyle.textLight)
      ScrollView(.horizontal) {
        Chart {
          ForEach(viewModel.forecast, id: \.date) { item in
            LineMark(x: .value("Hour", item.date.formatted(.dateTime.hour())),
                     y: .value("Temperature", item.temperature.formatted(Style.narrowTemperatureStyle)))

            .foregroundStyle(ColorStyle.secondary)
            .interpolationMethod(.catmullRom)
            .symbol {
              VStack(alignment: .center, spacing: 3) {
                Text(item.temperature.formatted(Style.narrowTemperatureStyle))
                  .font(.footnote)
                  .scaledToFill()
                  .minimumScaleFactor(0.5)
                  .lineLimit(1)
                  .foregroundColor(ColorStyle.text)

                Image(systemName: viewModel.safeSymbolName(item.symbolName))
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 20, height: 20, alignment: .center)
                  .foregroundStyle(viewModel.gradient)
                  .shadow(color: ColorStyle.primary, radius: 2, x: 0, y: 0)
              }
              .padding(.horizontal, 3)
              .background(ColorStyle.background)
            }
          }
        }
        .chartYAxis(.hidden)
        .chartXAxis {
          AxisMarks(position: .top) { value in
            AxisValueLabel(verticalSpacing: 20) {
              if let hourValue = value.as(String.self) {
                Text("\(hourValue)")
                  .font(.footnote)
                  .fontWeight(.medium)
                  .foregroundColor(ColorStyle.text)
              }
            }
          }
        }
        .frame(width: dataPointWidth * CGFloat(viewModel.numberOfHours))
        .padding(.bottom, 20)
      }

      .frame(height: chartHeight)
    }
    .padding(.horizontal, 5)
    .background(ColorStyle.background)
  }
}

struct HourlyForecastView_Preview: PreviewProvider {
  static let hourlyForecast = WeatherModel.sanFranciscoHourlyForecast!

  static var previews: some View {
    HourlyForecastChartView(viewModel: HourlyForecastChartViewModel(forecast: hourlyForecast))
      .previewLayout(.sizeThatFits)
  }
}
