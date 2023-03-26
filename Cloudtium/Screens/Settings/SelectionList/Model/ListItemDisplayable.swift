//
//  ListItemDisplayable.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import Foundation

protocol ListItemDisplayable {
    associatedtype T: Dimension

    var index: Int { get }
    var name: String { get }
    var unit: T { get }
}
