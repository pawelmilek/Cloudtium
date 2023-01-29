//
//  LocationManager.swift
//  SwiftyForecast
//
//  Created by Pawel Milek on 20/11/2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var authorizationStatus: CLAuthorizationStatus
  @Published var currentLocation: CLLocation?
  @Published var placemark: CLPlacemark?

  private var statusString: String {
    switch authorizationStatus {
    case .notDetermined: return "notDetermined"
    case .authorizedWhenInUse: return "authorizedWhenInUse"
    case .authorizedAlways: return "authorizedAlways"
    case .restricted: return "restricted"
    case .denied: return "denied"
    default: return "unknown"
    }
  }

  private let yieldLocationAfterDistanceInKilometers = 5
  private let manager: CLLocationManager

  override init() {
    manager = CLLocationManager()
    authorizationStatus = manager.authorizationStatus

    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyKilometer
    manager.distanceFilter = kCLDistanceFilterNone
    manager.startUpdatingLocation()
    manager.requestWhenInUseAuthorization()
  }

  func requestLocation() {
    manager.requestWhenInUseAuthorization()
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationStatus = status
    debugPrint(#function, statusString)
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last, shouldUpdateCurrentLocation(with: lastLocation) else { return }
    currentLocation = lastLocation
    placemark(for: lastLocation)

    debugPrint(#function, lastLocation)
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    debugPrint("Location manager did fail with error: \(error)")
  }

}

// MARK: - Private - Helper methods
private extension LocationManager {

  func shouldUpdateCurrentLocation(with newLocation: CLLocation) -> Bool {
    guard let distanceInKilometers = calculateDistance(from: newLocation) else { return true }
    return distanceInKilometers >= yieldLocationAfterDistanceInKilometers
  }

  func calculateDistance(from location: CLLocation) -> Int? {
    guard let currentLocation else { return nil }

    let distance = currentLocation.distance(from: location)
    let distanceInMeters = Measurement(value: distance, unit: UnitLength.meters)
    let distanceInKilometers = distanceInMeters.converted(to: .kilometers)

    return distanceInKilometers.value.toInt()
  }

  func placemark(for location: CLLocation?) {
    guard let location else { return }

    Task { @MainActor in
      do {
        placemark = try await CLGeocoder().reverseGeocodeLocation(location).first
      } catch {
        debugPrint(error)
      }
    }
  }

}
