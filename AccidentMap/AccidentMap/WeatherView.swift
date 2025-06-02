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
            if let location = locationManager.currentLocation {
                if let currentWeather = weatherServiceManager.currentWeather {
                    
                    Text("현재 기온은 \(currentWeather.temperature.formatted()) 입니다.")
                        .LevelStyle(backgroundColor: Color.customGreen)

                    Text("Condition: \(currentWeather.condition.description)")
                        .LevelStyle(backgroundColor: Color.customGreen)

                } else {
                    ProgressView("Loading weather data...")
                        .onAppear {
                            Task {
                                await weatherServiceManager.getWeather(for: location.coordinate)
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

#Preview {
    NavigationStack{
        WeatherView()
    }
}
