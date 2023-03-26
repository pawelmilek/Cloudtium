//
//  Double+ToInt.swift
//  Cloudtium
//
//  Created by Pawel Milek on 05/01/2023.
//

import Foundation

extension Double {

    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }

}
