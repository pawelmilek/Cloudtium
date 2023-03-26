//
//  DataLoadable.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

protocol DataLoadable {
    func load(filename: String) -> Data
}
