//
//  OnboardingPage.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/28/23.
//

import Foundation

enum OnboardingPage: Int, Identifiable, CaseIterable {
    case find
    case share

    var id: Int { self.rawValue }
}
