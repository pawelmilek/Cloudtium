//
//  PlistLocationDecoder.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

struct PlistLocationDecoder: DataDecodable {
    func decode<T>(_ type: T.Type, from data: Data) -> T where T: Decodable {
        do {
            let model = try PropertyListDecoder().decode(type.self, from: data)
            return model
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}
