//
//  WeatherView.swift
//  AccidentMap
//
//  Created by 김은정 on 6/2/25.
//

import SwiftUI
import CoreLocation


struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherServiceManager = WeatherServiceManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let currentWeather = weatherServiceManager.currentWeather {
                    Text("Temperature: \(currentWeather.temperature.formatted())")
                    Text("Condition: \(currentWeather.condition.description)")
                } else {
                    ProgressView("Loading weather data...")
                        .onAppear {
                            Task {
                                await weatherServiceManager.getWeather(for: location)
                            }
                        }
                }
            } else if let error = locationManager.errorMessage {
                Text(error)
            } else {
                ProgressView("Fetching location...")
            }
        }
        .padding()
    }
}


import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location.coordinate
        }
    }
    
    func locationManager( _ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to get user location: \(error.localizedDescription)"
    }
}


import Foundation
import WeatherKit
import CoreLocation


@MainActor
class WeatherServiceManager: ObservableObject {
    private let weatherService = WeatherService()  // 'shared'가 아닌 인스턴스 생성
    
    @Published var currentWeather: CurrentWeather?
    
    func getWeather(for location: CLLocationCoordinate2D) async {
        do {
            print("location: ", location)
            let weather = try await weatherService.weather(for: CLLocation(latitude: location.latitude, longitude: location.longitude))
            self.currentWeather = weather.currentWeather
        } catch {
            print("Failed to fetch weather data: \(error.localizedDescription)")
        }
    }
}
