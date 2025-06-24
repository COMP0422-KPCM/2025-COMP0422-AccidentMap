

import SwiftUI
import CoreLocation


struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherServiceManager = WeatherServiceManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.currentLocation {
                if let currentWeather = weatherServiceManager.currentWeather {
                    let bgColor = WeatherbackgroundColor(for: currentWeather.condition)
                    let WeatherText = WeatherText(for: currentWeather.condition)
                    Text("현재 기온은 \(currentWeather.temperature.formatted()) 입니다.")
                        .LevelStyle(backgroundColor: bgColor)

                    Text("현재 날씨는 \(WeatherText).")
                        .LevelStyle(backgroundColor: bgColor)

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
    }
}
<<<<<<< HEAD:AccidentMap/AccidentMap/WeatherView.swift

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

func WeatherbackgroundColor(for condition: WeatherKit.WeatherCondition) -> Color {
    switch condition {
    case .clear, .partlyCloudy:
        // 맑거나 약간 흐릴 때
        return Color.blue // 예시 색상
    case .cloudy:
        // 흐릴 때
        return Color.gray // 예시 색상
    case .rain, .heavyRain:
        // 비 올 때
        return Color.teal // 예시 색상 (청록색)
    case .snow, .flurries, .freezingRain, .sleet, .hail:
        // 눈 올 때
        return Color.cyan // 예시 색상 (하늘색)
    case .thunderstorms:
        // 천둥 번개 칠 때
        return Color.indigo // 예시 색상 (남색)
    case .windy:
        // 바람 많이 불 때
        return Color.mint // 예시 색상 (민트색)
    case .foggy:
        // 안개 낄 때
        return Color.secondary // 예시 색상 (회색 계열)
    // WeatherKit의 WeatherCondition에는 더 많은 케이스가 있습니다.
    // 필요에 따라 다른 상태(예: smokey, hazy 등)에 대한 색상도 추가할 수 있습니다.
    default:
        // 위에서 정의하지 않은 다른 모든 상태
        return Color.customGreen // 기본 색상 (기존 색상 유지 또는 다른 색상 선택)
    }
}

func WeatherText(for condition: WeatherKit.WeatherCondition) -> String {
    switch condition {
//        현재 날씨는
    case .clear, .partlyCloudy:
        // 맑거나 약간 흐릴 때
        return "맑아요" // 예시 색상
    case .cloudy:
        // 흐릴 때
        return "흐려요" // 예시 색상
    case .rain, .heavyRain:
        // 비 올 때
        return "비가와서 조심하세요" // 예시 색상 (청록색)
    case .snow, .flurries, .freezingRain, .sleet, .hail:
        // 눈 올 때
        return "눈이와서 매우 위험해요" // 예시 색상 (하늘색)
    case .thunderstorms:
        // 천둥 번개 칠 때
        return "천둥번개가 쳐요" // 예시 색상 (남색)
    case .windy:
        // 바람 많이 불 때
        return "바람이 많이 불어요" // 예시 색상 (민트색)
    case .foggy:
        // 안개 낄 때
        return "안개가 있으니 조심하세요" // 예시 색상 (회색 계열)
    // WeatherKit의 WeatherCondition에는 더 많은 케이스가 있습니다.
    // 필요에 따라 다른 상태(예: smokey, hazy 등)에 대한 색상도 추가할 수 있습니다.
    default:
        // 위에서 정의하지 않은 다른 모든 상태
        return "안전 운전 하세요" // 기본 색상 (기존 색상 유지 또는 다른 색상 선택)
    }
}




=======
>>>>>>> bcde987f73d3486dbab5def454586a57a42dd78c:AccidentMap/AccidentMap/Manager/WeatherTest/WeatherTest.swift
#Preview {
    NavigationStack{
        WeatherView()
    }
}
