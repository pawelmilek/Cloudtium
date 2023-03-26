//
//  DataDecodable.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

protocol DataDecodable {
    func decode<T>(_ type: T.Type, from data: Data) -> T where T: Decodable
}
