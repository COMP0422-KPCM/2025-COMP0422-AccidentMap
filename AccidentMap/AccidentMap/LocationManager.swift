//
//  LocationManager.swift
//  AccidentMap
//
//  Created by 김은정 on 6/1/25.
//

import Foundation
import SwiftUI
import CoreLocation

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//    
//    @Published var location: CLLocation?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        requestLocationAuthorization()
//    }
//    
//    func requestLocationAuthorization() {
//        locationManager.requestWhenInUseAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            locationManager.startUpdatingLocation()
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else { return }
//        location = newLocation
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}
