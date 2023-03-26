//
//  MainTabType.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/3/23.
//

import Foundation

enum MainTabType: Int, Identifiable {
    case home
    case favorite
    case settings

    var id: Int { self.rawValue }

    var name: String {
        switch self {
        case .home: return "Home"
        case .favorite: return "Favourite"
        case .settings: return "Settings"
        }
    }

    var symbol: String {
        switch self {
        case .home: return "house"
        case .favorite: return "suit.heart"
        case .settings: return "gearshape.fill"
        }
    }
}
