//
//  MainState.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation

struct MainState: ApplicationStateProtocol {
    let state = ApplicationState.main

    func apply(_ context: ApplicationStateManager) {
        context.hasPassedOnboarding = true
    }
}
