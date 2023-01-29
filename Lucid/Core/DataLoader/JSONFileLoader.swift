//
//  DataDecoder.swift
//  Lucid
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation
import os.log

struct JSONFileLoader {
  private let logger = Logger(subsystem: "milek.pawel.Lucid.JSONFileLoader", category: "ModelIO")

  private var dataURL: URL {
    get throws {
      guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
        throw CocoaError(.fileReadNoSuchFile)
      }

      return URL(fileURLWithPath: path)
    }
  }

  private let fileName: String

  init(fileName: String) {
    self.fileName = fileName
  }

  func load() -> Data? {
    var result: Data?
    do {
      result = try Data(contentsOf: dataURL, options: .mappedIfSafe)
      
    } catch CocoaError.fileReadNoSuchFile {
      logger.debug("No file found")
      result = nil

    } catch {
      logger.error("*** An error occurred while loading data: \(error.localizedDescription) ***")
      fatalError()
    }

    return result
  }
  
}
