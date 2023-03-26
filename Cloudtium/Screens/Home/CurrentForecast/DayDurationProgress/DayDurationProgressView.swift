//
//  DayDurationGaugeView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 09/01/2023.
//

import SwiftUI

struct DayDurationProgressView: View {
    @ObservedObject var viewModel: DayDurationProgressViewModel

    var body: some View {
        let _ = Self._printChanges()

        VStack(spacing: 5) {
            HStack {
                HStack {
                    Image(systemName: viewModel.daySymbol)
                        .imagePaletteModifier()
                        .frame(maxWidth: 22)
                    Text(viewModel.sunrise)
                        .font(.subheadline)
                        .foregroundStyle(ColorStyle.text)
                }
                .frameAlignment(.leading)

                Text(viewModel.dayTimeLeftDescription)
                    .font(.footnote)
                    .foregroundStyle(ColorStyle.text)
                HStack {
                    Text(viewModel.sunset)
                        .font(.subheadline)
                        .foregroundStyle(ColorStyle.text)
                    Image(systemName: viewModel.nightSymbol)
                        .imagePaletteModifier()
                        .frame(maxWidth: 22)
                }
                .frameAlignment(.trailing)
            }
            .fontDesign(.rounded)
            ProgressView(
                value: viewModel.minutesFromSunriseToNow,
                total: viewModel.maximumValueInMinutes
            )
            .progressViewStyle(ProgressViewBackgroundStyle())
        }
        .padding(.top, 20)
        .background(ColorStyle.background)
    }
}

struct DayDurationProgressView_Previews: PreviewProvider {
    static let sunEvents = WeatherModel.sanFranciscoDailyForecast!.forecast.first!.sun
    static let viewModel = DayDurationProgressViewModel(
        sunriseDate: sunEvents.sunrise!,
        sunsetDate: sunEvents.sunset!
    )

    static var previews: some View {
        DayDurationProgressView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
