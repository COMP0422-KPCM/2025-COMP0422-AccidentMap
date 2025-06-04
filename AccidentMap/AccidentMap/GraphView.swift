//
//  GraphView.swift
//  AccidentMap
//
//  Created by 김은정 on 6/3/25.
//

import SwiftUI
import Charts

// Accident 구조체 정의
struct Accident: Identifiable {
    let id: UUID
    let date: Date
    let latitude: Double
    let longitude: Double
    let severity: Int
    let Temperature: Double
    let Visibility: Double
    let Precipitation: Double
    let WeatherCondition: String // 날씨 조건
    let CivilTwilight: String // 시간대 구분
    
    static func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = 0 // 초는 0으로 설정
        components.timeZone = TimeZone.current // 현재 시간대 사용
        
        let calendar = Calendar.current
        return calendar.date(from: components) ?? Date()
    }
}

let dummyAccidents: [Accident] = [
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 1, hour: 18, minute: 45), latitude: 37.7749, longitude: -122.4194, severity: 1, Temperature: 12.3, Visibility: 8.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 2, hour: 8, minute: 30), latitude: 34.0522, longitude: -118.2437, severity: 2, Temperature: 15.5, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 3, hour: 22, minute: 0), latitude: 40.7128, longitude: -74.0060, severity: 3, Temperature: 5.1, Visibility: 2.5, Precipitation: 0.5, WeatherCondition: "Rain", CivilTwilight: "Night"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 4, hour: 7, minute: 15), latitude: 41.8781, longitude: -87.6298, severity: 1, Temperature: -2.0, Visibility: 0.5, Precipitation: 1.0, WeatherCondition: "Snow", CivilTwilight: "Night"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 5, hour: 14, minute: 0), latitude: 32.7767, longitude: -96.7970, severity: 2, Temperature: 20.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 6, hour: 19, minute: 30), latitude: 29.7604, longitude: -95.3698, severity: 3, Temperature: 18.5, Visibility: 1.0, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 7, hour: 9, minute: 0), latitude: 33.4484, longitude: -112.0740, severity: 1, Temperature: 25.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 8, hour: 17, minute: 0), latitude: 36.1699, longitude: -115.1398, severity: 2, Temperature: 22.0, Visibility: 9.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 9, hour: 21, minute: 0), latitude: 39.9526, longitude: -75.1652, severity: 3, Temperature: 8.0, Visibility: 3.0, Precipitation: 0.2, WeatherCondition: "Rain", CivilTwilight: "Night"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 10, hour: 6, minute: 0), latitude: 47.6062, longitude: -122.3321, severity: 1, Temperature: 0.0, Visibility: 0.1, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"), // Fog added to Night
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 11, hour: 13, minute: 0), latitude: 37.3382, longitude: -122.0317, severity: 2, Temperature: 17.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 12, hour: 18, minute: 0), latitude: 34.0522, longitude: -118.2437, severity: 3, Temperature: 16.0, Visibility: 7.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day")
]

// 날씨 조건별 빈도 계산
let weatherFrequency = dummyAccidents.reduce(into: [String: Int]()) { counts, accident in
    counts[accident.WeatherCondition, default: 0] += 1
}

// Civil Twilight 별 빈도 계산
let twilightFrequency = dummyAccidents.reduce(into: [String: Int]()) { counts, accident in
    counts[accident.CivilTwilight, default: 0] += 1
}

struct GraphView: View {
    @State private var GraphName = 0
    
    var body: some View {
        
        VStack(spacing:40) {
            Picker("Fruits", selection: $GraphName){
                Text("Weather").tag(0)
                Text("Civil Twilight").tag(1)
                Text("ETC").tag(2)
            }.pickerStyle(.segmented)
            
            if GraphName == 0 {
                VStack {
                    Text("날씨 조건별 사고 발생 빈도")
                        .font(.headline)
                    
                    Chart {
                        ForEach(weatherFrequency.sorted(by: { $0.key < $1.key }), id: \.key) { condition, count in
                            BarMark(
                                x: .value("날씨 조건", condition), // 날씨 조건을 x축에 표시
                                y: .value("빈도", count) // 빈도를 y축에 표시
                            )
                            // 막대 위에 빈도 값 표시
                            .annotation(position: .top) {
                                Text("\(count)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(height: 300) // 차트 높이 설정
                    .padding() // 패딩 추가
                }
            }
            
            
            else if GraphName == 1 {
                // Civil Twilight 빈도 분석 그래프
                VStack {
                    Text("시간대별 사고 발생 빈도")
                        .font(.headline)
                    
                    Chart {
                        // Dictionary 데이터를 Chart에 사용하기 위해 KeyValuePairs 형태로 변환
                        ForEach(twilightFrequency.sorted(by: { $0.key < $1.key }), id: \.key) { time, count in
                            SectorMark(
                                angle: .value("Severity", count),
                                //                              innerRadius: .ratio(0.5),
                                angularInset: 5.5
                                
                            )
                            .foregroundStyle(by: .value("time", time))
                            
                            
                        }
                    }
                    .padding()
                }
            }
            
            else {
                Text("시간대별 사고 발생 빈도")
                
            }
            
            Spacer()
            
        }

        
        
    }
    
}

// 프리뷰 제공
#Preview {
    GraphView()
}

