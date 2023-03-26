//
//  WeatherForecastView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 02/01/2023.
//

import SwiftUI

struct HomeView<VM>: View where VM: HomeViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        let _ = Self._printChanges()

        ScrollView {
            VStack(spacing: 15) {
                if let conditionViewModel = viewModel.conditionViewModel,
                   let detailViewModel = viewModel.detailViewModel,
                   let dayDurrationViewModel = viewModel.dayDurrationViewModel {
                    CurrentForecastView(
                        conditionViewModel: conditionViewModel,
                        detailViewModel: detailViewModel,
                        dayDurrationViewModel: dayDurrationViewModel
                    )
                } else {
                    noDataView
                }

                if let hourlyViewModel = viewModel.hourlyChartViewModel {
                    HourlyForecastChartView(viewModel: hourlyViewModel)
                } else {
                    noDataView
                }

                if let dailyViewModel = viewModel.dailyViewModel {
                    DailyForecastView(viewModel: dailyViewModel)
                } else {
                    noDataView
                }
            }
        }
        .background(ColorStyle.background)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.load()
        }
    }
}

// MARK: - Child views
private extension HomeView {

    var noDataView: some View {
        NoDataView(
            title: "Oops! Something went wrong.",
            description: "Data not found, please try again later."
        )
    }

}

struct HomeView_Previews: PreviewProvider {
    static let viewModel = MockHomeViewModel()

    static var previews: some View {
        HomeView(viewModel: viewModel)
    }
}
