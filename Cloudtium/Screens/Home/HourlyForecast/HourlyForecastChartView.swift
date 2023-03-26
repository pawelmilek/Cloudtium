//
//  HourlyForecastChartView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import SwiftUI
import WeatherKit
import Charts

struct HourlyForecastChartView: View {
    var viewModel: HourlyForecastChartViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today")
                .font(.callout)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundColor(ColorStyle.textLight)
            ScrollView(.horizontal) {
                Chart {
                    ForEach(viewModel.forecast, id: \.date) { item in
                        LineMark(x: .value("Hour", item.date.formatted(.dateTime.hour())),
                                 y: .value("Temperature", "\(Int(item.temperature.value))°"))

                        .foregroundStyle(ColorStyle.secondary)
                        .interpolationMethod(.catmullRom)
                        .symbol {
                            VStack(spacing: 5) {
                                Text("\(Int(item.temperature.value))°")
                                    .font(.subheadline)
                                    .fontDesign(.rounded)
                                    .scaledToFill()
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(ColorStyle.text)

                                Image(systemName: item.symbolName)
                                    .imagePaletteModifier()
                                    .frame(maxWidth: 25)
                            }
                            .padding(.horizontal, 0)
                            .background(ColorStyle.background)
                        }
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis {
                    AxisMarks(position: .top) { value in
                        AxisValueLabel(verticalSpacing: 35) {
                            if let hourValue = value.as(String.self) {
                                Text("\(hourValue)")
                                    .font(.subheadline)
                                    .foregroundColor(ColorStyle.text)
                            }
                        }
                    }
                }
                .frame(width: HourlyForecastChartViewModel.Constant.dataPointWidth * CGFloat(viewModel.numberOfHours))
                .padding(.bottom, 20)
            }
            .frame(height: HourlyForecastChartViewModel.Constant.chartHeight)
        }
        .padding(.horizontal, PaddingStyle.horizontal)
        .background(ColorStyle.background)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HourlyForecastChartView(viewModel: HourlyForecastChartViewModel(forecast: WeatherModel.sanFranciscoHourlyForecast!))
}
