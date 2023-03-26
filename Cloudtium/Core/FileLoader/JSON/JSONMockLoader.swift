//
//  JSONMockLoader.swift
//  Cloudtium
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation
import os.log

struct JSONMockLoader: DataLoadable {
    private static let fileExtension = "json"
    private let logger = Logger(subsystem: "milek.pawel.cloudtium.JSONLoader", category: "Model")

    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func load(filename: String) -> Data {
        do {
            let url = try fileURL(filename)
            let result = try Data(contentsOf: url, options: .mappedIfSafe)
            return result

        } catch CocoaError.fileReadNoSuchFile {
            logger.debug("No file found")
            fatalError("*** An error occurred no file found: \(CocoaError.fileReadNoSuchFile)")

        } catch {
            logger.error("Error loading data")
            fatalError("*** An error occurred while loading data: \(error.localizedDescription) ***")
        }
    }

    private func fileURL(_ filename: String) throws -> URL {
        guard let path = bundle.path(forResource: filename, ofType: Self.fileExtension) else {
            throw CocoaError(.fileReadNoSuchFile)
        }

        return URL(fileURLWithPath: path)
    }
}
