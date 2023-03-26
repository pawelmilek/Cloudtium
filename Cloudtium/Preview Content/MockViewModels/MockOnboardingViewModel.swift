//
//  MockOnboardingViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/3/23.
//

import Foundation

final class MockOnboardingViewModel: OnboardingViewModelProtocol {
    @Published var shouldShowAddLocation = false
    @Published var shouldRequestAuthorization = false
    @Published private(set) var pages = [PageViewModel]()

    func load() {
        pages = [PageViewModel.makeFirstPageViewModel(),
                 PageViewModel.makeSecondPageViewModel()]
    }
}
