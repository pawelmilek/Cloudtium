//
//  ForecastError.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/3/23.
//

import Foundation

enum ForecastError: Error {
    case locationUnavailable
    case placemarkUnavailable
    case other
}
