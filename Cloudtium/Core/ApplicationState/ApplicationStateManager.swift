//
//  ApplicationStateManager.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/31/23.
//

import Foundation
import SwiftUI

final class ApplicationStateManager: ObservableObject {
    enum UserDefaultsKey {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }

    @AppStorage(UserDefaultsKey.hasSeenOnboarding) var hasPassedOnboarding = false
    @Published var currentState: ApplicationStateProtocol?

    func onboarding() {
        transition(to: OnboardingState())
    }

    func main() {
        transition(to: MainState())
    }

    private func transition(to state: ApplicationStateProtocol) {
        currentState = state
        currentState?.apply(self)
    }

    func configure() {
        if hasPassedOnboarding {
            main()
        } else {
            onboarding()
        }
    }
}
