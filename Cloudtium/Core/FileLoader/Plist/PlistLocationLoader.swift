//
//  PlistLocationLoader.swift
//  Cloudtium
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation
import os.log

struct PlistLocationLoader: DataLoadable {
    private static let fileExtension = "plist"
    private let logger = Logger(subsystem: "milek.pawel.cloudtium.PlistLoader", category: "Model")

//    func load(filename: String) -> LocationModel? {
//        var result: LocationModel?
//
//        do {
//            let path = try filePath(filename)
//            guard let plistData = FileManager.default.contents(atPath: path) else { return nil }
//
//            result = try PropertyListSerialization.propertyList(from: plistData,
//                                                                options: .mutableContainersAndLeaves,
//                                                                format: nil) as? LocationModel
//        } catch CocoaError.fileReadNoSuchFile {
//            logger.debug("No file found")
//            result = nil
//
//        } catch {
//            logger.error("*** An error occurred while loading data: \(error.localizedDescription) ***")
//            fatalError()
//        }
//        return result
//    }

    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func load(filename: String) -> Data {
        do {
            let path = try filePath(filename)
            guard let data = FileManager.default.contents(atPath: path) else {
                throw CocoaError(.fileReadNoSuchFile)
            }

            return data

        } catch CocoaError.fileReadNoSuchFile {
            logger.debug("No file found")
            fatalError("*** No file found \(CocoaError.fileReadNoSuchFile) ***")

        } catch {
            logger.error("Error loading data")
            fatalError("*** An error occurred while loading data: \(error.localizedDescription) ***")
        }
    }

    private func filePath(_ filename: String) throws -> String {
        guard let path = bundle.path(forResource: filename, ofType: Self.fileExtension) else {
            throw CocoaError(.fileReadNoSuchFile)
        }

        return path
    }
}
