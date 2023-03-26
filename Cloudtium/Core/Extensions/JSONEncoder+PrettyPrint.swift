//
//  JSONEncoder+PrettyPrint.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

extension JSONEncoder {

    static func prettyPrint<T>(_ data: T) where T: Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encodedData = try? encoder.encode(data),
           let jsonString = String(data: encodedData, encoding: .utf8) {
            print(jsonString)
        }
    }

}
