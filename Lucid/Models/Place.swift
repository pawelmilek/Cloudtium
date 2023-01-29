//
//  Place.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation
import CoreLocation

struct Place: Hashable, Identifiable, Sendable {
  var id = UUID()
  var city: String
  var region: String
  var country: String
  var countryCode: String
  var latitude: Double
  var longitude: Double

  var location: CLLocation {
      CLLocation(latitude: latitude, longitude: longitude)
  }

  var locationDescription: String {
    return "\(city), \(region), \(countryCode)"
  }

}

// MARK: - Init
extension Place {

  init(placemark: CLPlacemark) {
    self.city = placemark.locality ?? InvalidReference.undefined
    self.region = placemark.administrativeArea ?? InvalidReference.undefined
    self.country = placemark.country ?? InvalidReference.undefined
    self.countryCode = placemark.isoCountryCode ?? InvalidReference.undefined
    self.latitude = placemark.location!.coordinate.latitude
    self.longitude = placemark.location!.coordinate.longitude
  }

}

// MARK: - Codable
extension Place: Codable {
    enum CodingKeys: String, CodingKey {
        case city
        case region
        case country
        case countryCode
        case latitude = "lat"
        case longitude = "lon"
    }
}

// MARK: - Comparable
extension Place: Comparable {
    static func <(lhs: Place, rhs: Place) -> Bool {
        lhs.locationDescription < rhs.locationDescription
    }
}

// MARK: - DEBUG - Use it for Preview and mock data
#if DEBUG
extension Place {

  static var all: [Place] {
    guard let data = JSONFileLoader(fileName: "mock_places").load() else { return [] }
    let model = DataDecoder<[Place]>.decode(data)

    if case .success(let decodedModel) = model {
      return decodedModel
    }

    return []
  }

  static var chicago: Place {
    all.first(where: { $0.city.lowercased() == "chicago" })!
  }

  static var rzeszow: Place {
    all.first(where: { $0.city.lowercased() == "rzeszow" })!
  }

  static var dallas: Place {
    all.first(where: { $0.city.lowercased() == "dallas" })!
  }

  static var sanFrancisco: Place {
    all.first(where: { $0.city.lowercased() == "san francisco" })!
  }

}
#endif
