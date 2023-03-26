//
//  SpeedListDataSource.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import Foundation

struct SpeedListDataSource: SelectionListDataSource {
    let items: [SpeedItem]
    var numberOfItems: Int { items.count }

    func item(at index: Int) -> SpeedItem? {
        items.first(where: { $0.index == index })
    }
}
