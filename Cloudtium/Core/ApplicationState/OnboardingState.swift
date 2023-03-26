//
//  OnboardingState.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation

struct OnboardingState: ApplicationStateProtocol {
    let state = ApplicationState.onboarding

    func apply(_ context: ApplicationStateManager) {
        context.hasPassedOnboarding = false
    }
}
