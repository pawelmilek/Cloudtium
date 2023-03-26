//
//  FileIOController.swift
//  Cloudtium
//
//  Created by Pawel Milek on 9/1/23.
//

import Foundation

struct FileIOController {
    private let manager: FileManager

    init(manager: FileManager = FileManager.default) {
        self.manager = manager
    }

    func write<T: Encodable>(
        _ object: T,
        toDocumentNamed documentName: String,
        encodedUsing encoder: JSONEncoder = .init()
    ) throws {
        let rootFolderURL = try manager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )

        let nestedFolderURL = rootFolderURL.appendingPathComponent("MyAppFiles")
        do {
            try manager.createDirectory(
                at: nestedFolderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
        } catch CocoaError.fileWriteFileExists {
            // Ignore error when folder already existed.
        } catch {
            throw error
        }

        let fileURL = nestedFolderURL.appendingPathComponent(documentName)
        let data = try encoder.encode(object)
        try data.write(to: fileURL)
    }
}
