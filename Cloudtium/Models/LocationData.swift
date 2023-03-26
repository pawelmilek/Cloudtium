//
//  LocationData.swift
//  Cloudtium
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation
import os.log

@MainActor
class LocationData: ObservableObject {
    let logger = Logger(subsystem: "milek.pawel.cloudtium.LocationData", category: "Model")

    @Published private(set) var locations: [LocationModel]

    private let store = Store()

    init(locations: [LocationModel] = []) {
        self.locations = locations
    }

    static func loadMockData() -> LocationModel {
        LocationModel(
            city: "Chicago",
            region: "Illinois",
            country: "USA",
            countryCode: "US",
            latitude: 41.878113,
            longitude: -87.629799
        )
    }
}

extension LocationData {
    private actor Store {
        let logger = Logger(subsystem: "milek.pawel.cloudtium.LocationData.Store", category: "Model")

        func load() -> [LocationModel] {
            load(from: .main)
        }

        private func load(from bundle: Bundle) -> [LocationModel] {
            logger.debug("Loading the data from disk.")

            var locations: [LocationModel]
            do {
                let data = try Data(contentsOf: Store.dataURL, options: .mappedIfSafe)
                locations = try JSONDecoder().decode([LocationModel].self, from: data)
            } catch CocoaError.fileReadNoSuchFile {
                logger.debug("No file found -- creating an empty airport list.")
                locations = []
            } catch {
                logger.error("*** An error occurred while loading the airport list: \(error.localizedDescription) ***")
                fatalError()
            }
            return locations
        }

        // Provide the URL for the JSON file that stores the place data.
        fileprivate static var dataURL: URL {
            get throws {
                let bundle = Bundle.main
                guard let path = bundle.path(forResource: "mock_locations", ofType: "json") else {
                    throw CocoaError(.fileReadNoSuchFile)
                }
                return URL(fileURLWithPath: path)
            }
        }
    }
}
