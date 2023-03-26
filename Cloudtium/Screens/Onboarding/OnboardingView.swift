//
//  OnboardingView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/15/23.
//

import SwiftUI
import OSLog

struct OnboardingView<VM>: View where VM: OnboardingViewModelProtocol {
    @EnvironmentObject var stateManager: ApplicationStateManager
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            TabView {
                ForEach(viewModel.pages) { page in
                    PageView(viewModel: page)
                        .tag(page.id)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .onAppear {
            viewModel.load()
        }
        .onChange(of: viewModel.shouldRequestAuthorization, initial: true) {
            guard viewModel.shouldRequestAuthorization else { return }
            locationManager.requestAuthorization()
        }
        .onChange(of: locationManager.authorizationStatus, initial: true) {
            if case .authorizedWhenInUse = locationManager.authorizationStatus {
                withAnimation {
                    stateManager.main()
                }
            }
        }
        .onChange(of: viewModel.shouldShowAddLocation, initial: true) {
            if !viewModel.shouldShowAddLocation {
                withAnimation {
                    stateManager.main()
                }
            }
        }
        .sheet(isPresented: $viewModel.shouldShowAddLocation) {
            VStack {
                Text("Here are some other locations you might find helpful")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                TextField("find location", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                List {
                    Text("London")
                    Text("Chicago")
                    Text("Miami")
                    Text("Rzeszow")
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: MockOnboardingViewModel())
            .environmentObject(ApplicationStateManager())
            .environmentObject(LocationManager())
    }
}
