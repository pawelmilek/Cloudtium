//
//  CurrentPlaceConditionView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 11/01/2023.
//

import SwiftUI

struct CurrentConditionView: View {
    @ObservedObject var viewModel: CurrentConditionViewModel

    var body: some View {
        let _ = Self._printChanges()

        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.location)
                        .font(.title2)
                    Text(viewModel.temperature)
                        .font(.system(size: 80))
                        .fontWeight(.semibold)
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    VStack(alignment: .leading) {
                        Text(viewModel.maxMinTemperature)
                            .offset(y: -20)
                        Text(viewModel.shortConditionDescription)
                            .padding(.horizontal, 20)
                            .frame(height: 30)
                            .background(ColorStyle.capsule)
                            .clipShape(Capsule())
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                }
                .frameAlignment(.leading)
                .fontDesign(.rounded)
                .padding(.top, 0)
                .padding(.bottom, 15)
                Image(systemName: viewModel.symbol)
                    .imagePaletteModifier()
                    .frame(maxWidth: 150)
                    .shadow(color: ColorStyle.primary, radius: 35, x: 0, y: 10)
                    .offset(x: -30)
            }
            .fontDesign(.rounded)
            .foregroundColor(ColorStyle.text)
        }
    }
}

struct CurrentConditionView_Previews: PreviewProvider {
    static let locationName = LocationModel.sanFrancisco.city
    static let current = WeatherModel.sanFranciscoCurrentWeather!
    static let daily = WeatherModel.sanFranciscoDailyForecast!

    static let viewModel = CurrentConditionViewModel(
        locationName: locationName,
        current: current,
        daily: daily
    )

    static var previews: some View {
        CurrentConditionView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
