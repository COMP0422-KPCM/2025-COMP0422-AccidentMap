

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
#Preview {
    NavigationStack{
        WeatherView()
    }
}
