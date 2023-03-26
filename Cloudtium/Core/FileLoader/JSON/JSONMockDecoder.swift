//
//  JSONMockDecoder.swift
//  Cloudtium
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation

struct JSONMockDecoder: DataDecodable {
    func decode<T>(_ type: T.Type, from data: Data) -> T where T: Decodable {
        do {
          let model = try JSONDecoder().decode(type.self, from: data)
          return model
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}
