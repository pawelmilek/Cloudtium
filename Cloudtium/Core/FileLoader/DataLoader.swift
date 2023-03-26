//
//  DataLoader.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

struct DataLoader<T: Decodable> {
    private let loader: any DataLoadable
    private let decoder: any DataDecodable

    init(loader: any DataLoadable, decoder: any DataDecodable) {
        self.loader = loader
        self.decoder = decoder
    }

    func load(filename: String) -> T? {
        let data = loader.load(filename: filename)
        let result = decoder.decode(T.self, from: data)
        return result
    }
}
