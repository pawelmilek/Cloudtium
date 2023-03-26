//
//  ContentView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var stateManager: ApplicationStateManager
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject var mainViewModel: MainViewModel

    var body: some View {
        let _ = Self._printChanges()

        ZStack {
            BackgroundView(color: ColorStyle.background)
            if let state = stateManager.currentState?.state {
                switch state {
                case .onboarding:
                    OnboardingView(viewModel: onboardingViewModel)
                        .transition(.asymmetric(insertion: .opacity,
                                                removal: .move(edge: .leading)))

                case .main:
                    MainView(viewModel: mainViewModel)
                        .transition(.asymmetric(insertion: .opacity,
                                                removal: .move(edge: .trailing)))
                }
            } else {
                noActionErrorView
            }
        }
        .onAppear {
            stateManager.configure()
        }
    }
}

// MARK: - Error views
private extension ContentView {

    var noActionErrorView: some View {
        ErrorView(
            title: "Oops! Something went wrong.",
            description: "The application has encountered an unknown error.",
            showAction: false
        )
    }

}

struct ContentView_Previews: PreviewProvider {
    static var locationManager = LocationManager()
    static let stateManager = ApplicationStateManager()
    static let onboardingViewModel = OnboardingViewModel()
    static let mainViewModel = MainViewModel(weatherModel: WeatherModel())

    static var previews: some View {
        ContentView()
            .environmentObject(locationManager)
            .environmentObject(stateManager)
            .environmentObject(onboardingViewModel)
            .environmentObject(mainViewModel)
    }
}
