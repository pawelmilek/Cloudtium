//
//  PageModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/18/23.
//

import Foundation

struct PageModel {
    let symbol: String
    let title: String
    let titleColorWord: String
    let subheadline: String
    let buttonTitle: (primary: String, secondary: String)?
}

// MARK: - Defaults
extension PageModel {

    static let firstPageModel = PageModel(
        symbol: "magnifyingglass.circle.fill",
        title: "Find your weather predictions.",
        titleColorWord: "Find",
        subheadline: "Easy steps to predict the weater",
        buttonTitle: nil
    )

    static let secondPageModel = PageModel(
        symbol: "location.circle.fill",
        title: "Would you like to share your location?",
        titleColorWord: "share",
        subheadline: "Start sharing your location with us",
        buttonTitle: ("Share", "Add location")
    )

}
