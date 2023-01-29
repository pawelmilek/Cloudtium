import Foundation
import os.log

struct PlistFileLoader {
  private let logger = Logger(subsystem: "milek.pawel.Lucid.PlistFileLoader", category: "ModelIO")
  private var plistXML: Data? {
    get throws {
      guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
        throw CocoaError(.fileReadNoSuchFile)
      }

      return FileManager.default.contents(atPath: path)
    }
  }

  private let fileName: String

  init(fileName: String) {
    self.fileName = fileName
  }

  func load<T>() -> T? {
    var result: T?
    do {
      result = try PropertyListSerialization.propertyList(from: plistXML!,
                                                          options: .mutableContainersAndLeaves,
                                                          format: nil) as? T

    } catch CocoaError.fileReadNoSuchFile {
      logger.debug("No file found")
      result = nil

    } catch {
      logger.error("*** An error occurred while loading data: \(error.localizedDescription) ***")
      fatalError()
    }
    return result
  }
  
  func load<T: Decodable>() -> T? {
    var result: T?
    do {
      result = try PropertyListDecoder().decode(T.self, from: plistXML!)

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
