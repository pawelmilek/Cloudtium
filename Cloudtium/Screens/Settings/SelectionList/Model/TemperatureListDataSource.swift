//
//  TemperatureListDataSource.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import Foundation

struct TemperatureListDataSource: SelectionListDataSource {
    let items: [TemperatureItem]
    var numberOfItems: Int { items.count }

    func item(at index: Int) -> TemperatureItem? {
        items.first(where: { $0.index == index })
    }
}
