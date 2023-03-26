//
//  ContentView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        let _ = Self._printChanges()

        ZStack {
            BackgroundView(color: ColorStyle.background)
            TabView(selection: $viewModel.selectedTab) {
                homeView
                    .tabItem {
                        Image(systemName: MainTabType.home.symbol)
                    }
                    .tag(MainTabType.home)

                favoritesView
                    .tabItem {
                        Image(systemName: MainTabType.favorite.symbol)
                    }
                    .tag(MainTabType.favorite)

                settingsView
                    .tabItem {
                        Image(systemName: MainTabType.settings.symbol)
                    }
                    .tag(MainTabType.settings)
            }
            .accentColor(ColorStyle.accent)
        }
        .onReceive(locationManager.$authorizationStatus) { value in
            if case .notDetermined = value {
                locationManager.requestAuthorization()
            }

            if case .authorizedWhenInUse = value {
                locationManager.requestLocation()
            }
        }
        .task(id: locationManager.currentLocation, priority: .userInitiated) {
            guard let currentLocation = locationManager.currentLocation else {
                locationManager.requestLocation()
                return
            }
            print("await viewModel.load(for: currentLocation)")
            await viewModel.load(for: currentLocation)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .tint(ColorStyle.accent)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        ColorStyle.background.opacity(0.9)
                    }
            }
        }
        .fullScreenCover(
            isPresented: $viewModel.showError,
            onDismiss: didDismiss
        ) {
            actionErrorView
        }
    }

    private func didDismiss() {
        locationManager.requestLocation()
    }
}

// MARK: - Child views
private extension MainView {

    var homeView: some View {
        VStack {
            if let viewModel = viewModel.homeViewModel {
                HomeView(viewModel: viewModel)
            } else {
                BackgroundView(color: ColorStyle.background)
            }
        }
    }

    var favoritesView: some View {
        VStack {
            if let viewModel = viewModel.favoriteViewModel {
                FavoriteView(viewModel: viewModel)
            } else {
                BackgroundView(color: ColorStyle.background)
            }
        }
    }

    var settingsView: some View {
        VStack {
            if let viewModel = viewModel.settingsViewModel {
                SettingsView(viewModel: viewModel)
            } else {
                BackgroundView(color: ColorStyle.background)
            }
        }
    }

    var actionErrorView: some View {
        ErrorView(
            title: "Oops! Something went wrong.",
            description: "The application has encountered an unknown error.",
            showAction: true
        )
    }

}

struct MainView_Previews: PreviewProvider {
    static var locationManager = LocationManager()
    static var settingsStorage = SettingsStorage.shared
    static var viewModel = MainViewModel(weatherModel: WeatherModel())

    static var previews: some View {
        MainView(viewModel: viewModel)
            .environmentObject(settingsStorage)
            .environmentObject(locationManager)
            .environmentObject(viewModel)
    }
}
