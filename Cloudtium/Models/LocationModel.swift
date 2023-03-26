//
//  LocationModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation
import CoreLocation
import MapKit

struct LocationModel: Hashable, Identifiable, Sendable {
    let id = UUID()
    var city: String
    var region: String
    var country: String
    var countryCode: String
    var latitude: Double
    var longitude: Double

    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Init
extension LocationModel {

    init() {
        self.city = ""
        self.region = ""
        self.country = ""
        self.countryCode = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }

    init(placemark: CLPlacemark) {
        self.city = placemark.locality ?? InvalidReference.undefined
        self.region = placemark.administrativeArea ?? InvalidReference.undefined
        self.country = placemark.country ?? InvalidReference.undefined
        self.countryCode = placemark.isoCountryCode ?? InvalidReference.undefined
        self.latitude = placemark.location!.coordinate.latitude
        self.longitude = placemark.location!.coordinate.longitude
    }

    init(placemark: MKPlacemark) {
        self.city = placemark.locality ?? InvalidReference.undefined
        self.region = placemark.administrativeArea ?? InvalidReference.undefined
        self.country = placemark.country ?? InvalidReference.undefined
        self.countryCode = placemark.isoCountryCode ?? InvalidReference.undefined
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
    }

}

// MARK: - Codable
extension LocationModel: Codable {
    enum CodingKeys: String, CodingKey {
        case city
        case region
        case country
        case countryCode
        case latitude = "lat"
        case longitude = "lon"
    }
}

// MARK: - DEBUG - Use it for Preview and mock data
#if DEBUG
extension LocationModel {

    static var all: [LocationModel] {
        let dataLoader = DataLoader<[LocationModel]>(loader: JSONMockLoader(), decoder: JSONMockDecoder())
        if let model = dataLoader.load(filename: "mock_locations") {
            return model
        }

        return []
    }

    static var chicago: LocationModel {
        all.first(where: { $0.city.lowercased() == "chicago" })!
    }

    static var rzeszow: LocationModel {
        all.first(where: { $0.city.lowercased() == "rzeszow" })!
    }

    static var dallas: LocationModel {
        all.first(where: { $0.city.lowercased() == "dallas" })!
    }

    static var sanFrancisco: LocationModel {
        all.first(where: { $0.city.lowercased() == "san francisco" })!
    }

}
#endif
