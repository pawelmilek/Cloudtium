//
//  OnboardingViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/30/23.
//

import Foundation
import SwiftUI

protocol OnboardingViewModelProtocol: AnyObject, ObservableObject {
    var shouldShowAddLocation: Bool { get set }
    var shouldRequestAuthorization: Bool { get set }
    var pages: [PageViewModel] { get }

    func load()
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    @Published var shouldShowAddLocation = false
    @Published var shouldRequestAuthorization = false
    @Published private(set) var pages = [PageViewModel]()

    func load() {
        pages = [makeFirstPageViewModel(), makeSecondPageViewModel()]
    }

    private func shareLocation() {
        shouldRequestAuthorization.toggle()
    }

    private func addLocation() {
        shouldShowAddLocation.toggle()
    }
}

// MARK: - Helpers
private extension OnboardingViewModel {

    private func makeFirstPageViewModel() -> PageViewModel {
        let viewModel = PageViewModel.makeFirstPageViewModel()
        return viewModel
    }

    private func makeSecondPageViewModel() -> PageViewModel {
        let viewModel = PageViewModel.makeSecondPageViewModel()
        viewModel.onPrimaryAction = { [self] in
            shareLocation()
        }

        viewModel.onSecondaryAction = { [self] in
            addLocation()
        }
        return viewModel
    }

}
