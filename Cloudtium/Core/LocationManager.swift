//
//  LocationManager.swift
//  SwiftyForecast
//
//  Created by Pawel Milek on 20/11/2022.
//

import Foundation
import CoreLocation
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var currentLocation: CLLocation?

    private let manager: CLLocationManager

    override init() {
        manager = CLLocationManager()
        authorizationStatus = manager.authorizationStatus

        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.allowsBackgroundLocationUpdates = true
        manager.activityType = .other
    }

    func requestLocation() {
        debugPrint(#function)
        manager.requestLocation()
    }

    func startUpdatingLocation() {
        debugPrint(#function)
        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        debugPrint(#function)
        manager.stopUpdatingLocation()
    }

    func requestAuthorization() {
        debugPrint(#function)
        manager.requestWhenInUseAuthorization()
    }

}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        debugPrint(#function, manager.authorizationStatus.description)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        self.currentLocation = lastLocation

        debugPrint(#function, currentLocation!)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let code = (error as NSError).code

        if code == CLError.Code.locationUnknown.rawValue {
            debugPrint("Unable to retrieve a location right away keeps trying...")

        } else if code == CLError.Code.denied.rawValue {
            manager.stopUpdatingLocation()
        }

        debugPrint(#function, code)
    }

}

// MAKR: - CustomStringConvertible
extension CLAuthorizationStatus: CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:
            return "notDetermined"

        case .authorizedWhenInUse:
            return "authorizedWhenInUse"

        case .authorizedAlways:
            return "authorizedAlways"

        case .restricted:
            return "restricted"

        case .denied:
            return "denied"

        default:
            return "unknown"
        }
    }

}
