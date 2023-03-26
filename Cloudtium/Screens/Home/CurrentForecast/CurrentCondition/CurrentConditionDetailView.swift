//
//  CurrentConditionDetailView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 11/01/2023.
//

import SwiftUI

struct CurrentConditionDetailView: View {
    @ObservedObject var viewModel: CurrentConditionDetailViewModel

    var body: some View {
        let _ = Self._printChanges()

        HStack {
            humidityView
                .frameAlignment(.leading)
            pressureView
                .frameAlignment(.center)
            windSpeedView
                .frameAlignment(.trailing)
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .fontDesign(.rounded)
        .foregroundColor(ColorStyle.text)
        .onAppear {
            viewModel.load()
            print("CurrentConditionDetailView onAppear - \(viewModel.speed)")
        }
        .onChange(of: viewModel.speed, initial: true) {
            print("CurrentConditionDetailView onChange - \(viewModel.speed)")
        }
        .onReceive(viewModel.$speed) { value in
            print("CurrentConditionDetailView onReceive - \(value)")
        }
    }
}

// MARK: - Child views
private extension CurrentConditionDetailView {

    var humidityView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: viewModel.humiditySymbol)
                .foregroundColor(ColorStyle.condition)
            Text(viewModel.humidity)
        }
    }

    var pressureView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: viewModel.pressureSymbol)
                .foregroundColor(ColorStyle.condition)
            Text(viewModel.pressure)
        }
    }

    var windSpeedView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: viewModel.windSymbol)
                .foregroundColor(ColorStyle.condition)
            Text(viewModel.speed)
        }
    }
}

struct CurrentConditionDetailsView_Previews: PreviewProvider {
    static let current = WeatherModel.sanFranciscoCurrentWeather!
    static let viewModel = CurrentConditionDetailViewModel(
        humidity: current.humidity,
        pressureMeasurement: current.pressure,
        speedMeasurement: current.wind.speed
    )

    static var previews: some View {
        CurrentConditionDetailView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
