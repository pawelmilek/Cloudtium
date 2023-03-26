//
//  SettingsView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI
import WeatherKit

struct SettingsView: View {
    @EnvironmentObject var settingsStorage: SettingsStorage
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        let _ = Self._printChanges()

        NavigationStack {
            ZStack {
                BackgroundView(color: ColorStyle.background)
                VStack(spacing: 15) {
                    UserLocationView(location: viewModel.locationDescription)
                    moonphaseView
                    conditionView
                    selectionListView
                }
            }
        }
    }
}

// MARK: - Child views
private extension SettingsView {

    var moonphaseView: some View {
        VStack {
            Image(systemName: viewModel.moonphaseSymbol)
                .imagePaletteModifier()
                .frame(width: 150)
                .shadow(color: ColorStyle.primary, radius: 38, x: 0, y: 0)
                .padding()

            Text(viewModel.moonphaseDescription)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .frame(height: 33)
                .padding(.horizontal, 20)
                .foregroundColor(ColorStyle.text)
                .background(ColorStyle.capsule)
                .clipShape(Capsule())
        }
    }

    var conditionView: some View {
        VStack(spacing: 15) {
            Text(viewModel.temperature)
                .font(.system(size: 80))
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(ColorStyle.text)

            CurrentConditionDetailView(viewModel: viewModel.detailViewModel)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
        }
    }

    var selectionListView: some View {
        List {
            NavigationLink(destination: {
                SelectionListView(
                    title: "Temperature",
                    dataSource: viewModel.listProviderTemperature,
                    checkmarkIndex: $viewModel.temperatureCheckmarkIndex
                )
            }, label: {
                HStack {
                    Text("Temperature")
                        .frameAlignment(.leading)
                    Text(settingsStorage.temperatureSymbol)
                        .foregroundColor(ColorStyle.condition)
                        .padding(.horizontal, 5)
                }
            })
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            NavigationLink(destination: {
                SelectionListView(
                    title: "Wind Speed",
                    dataSource: viewModel.listProviderSpeed,
                    checkmarkIndex: $viewModel.speedCheckmarkIndex
                )
            }, label: {
                HStack {
                    Text("Wind Speed")
                        .frameAlignment(.leading)
                    Text(settingsStorage.speedSymbol)
                        .foregroundColor(ColorStyle.condition)
                        .padding(.horizontal, 5)
                }
            })
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            HStack {
                Text("Source")
                    .frameAlignment(.leading)
                LinkAttributionView(attribution: viewModel.attribution)
                    .frame(width: 60)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

        }
        .listStyle(.plain)
        .font(.subheadline)
        .fontWeight(.semibold)
        .fontDesign(.rounded)
        .foregroundColor(ColorStyle.text)
        .scrollContentBackground(.hidden)
    }

}

struct SettingsView_Previews: PreviewProvider {
    static let current = WeatherModel.sanFranciscoCurrentWeather!
    static let noonEvents = WeatherModel.sanFranciscoDailyForecast!.forecast.first!.moon
    static let weatherAttribution = WeatherModel.weatherAttribution!

    static let viewModel = SettingsViewModel(
        location: LocationModel.sanFrancisco,
        currentWeather: current,
        moonPhase: noonEvents.phase,
        weatherAttribution: weatherAttribution
    )

    static var previews: some View {
        SettingsView(viewModel: viewModel)
            .environmentObject(SettingsStorage.shared)
    }
}
