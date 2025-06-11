////
////  Accident.swift
////  AccidentMap
////
////  Created by 문재윤 on 6/11/25.
////
//
//
////
////  GraphView.swift
////  AccidentMap
////
////  Created by 김은정 on 6/3/25.
////
//
//import SwiftUI
//import Charts
//
//struct Accident: Identifiable {
//    let id: UUID
//    let date: Date
//    let latitude: Double
//    let longitude: Double
//    let severity: Int
//    let Temperature: Double
//    let Visibility: Double
//    let Precipitation: Double
//    let WeatherCondition: String
//    let CivilTwilight: String
//    
//    static func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
//        var components = DateComponents()
//        components.year = year
//        components.month = month
//        components.day = day
//        components.hour = hour
//        components.minute = minute
//        components.second = 0
//        components.timeZone = TimeZone.current
//        
//        return Calendar.current.date(from: components) ?? Date()
//    }
//}
//
//let dummyAccidents: [Accident] = [
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 1, hour: 18, minute: 45), latitude: 37.7749, longitude: -122.4194, severity: 1, Temperature: 12.3, Visibility: 8.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 1, hour: 19, minute: 10), latitude: 37.7749, longitude: -122.4194, severity: 3, Temperature: 11.0, Visibility: 7.0, Precipitation: 0.1, WeatherCondition: "Clear", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 2, hour: 8, minute: 30), latitude: 34.0522, longitude: -118.2437, severity: 2, Temperature: 15.5, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Rain", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 2, hour: 9, minute: 0), latitude: 34.0522, longitude: -118.2437, severity: 4, Temperature: 14.0, Visibility: 9.0, Precipitation: 0.5, WeatherCondition: "Rain", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 3, hour: 22, minute: 0), latitude: 40.7128, longitude: -74.0060, severity: 1, Temperature: 5.1, Visibility: 2.5, Precipitation: 0.5, WeatherCondition: "Fog", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 1, hour: 18, minute: 45), latitude: 37.7749, longitude: -122.4194, severity: 1, Temperature: 12.3, Visibility: 8.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 2, hour: 8, minute: 30), latitude: 34.0522, longitude: -118.2437, severity: 2, Temperature: 15.5, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 3, hour: 22, minute: 0), latitude: 40.7128, longitude: -74.0060, severity: 3, Temperature: 5.1, Visibility: 2.5, Precipitation: 0.5, WeatherCondition: "Rain", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 4, hour: 7, minute: 15), latitude: 41.8781, longitude: -87.6298, severity: 1, Temperature: -2.0, Visibility: 0.5, Precipitation: 1.0, WeatherCondition: "Snow", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 5, hour: 14, minute: 0), latitude: 32.7767, longitude: -96.7970, severity: 2, Temperature: 20.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 6, hour: 19, minute: 30), latitude: 29.7604, longitude: -95.3698, severity: 3, Temperature: 18.5, Visibility: 1.0, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 7, hour: 9, minute: 0), latitude: 33.4484, longitude: -112.0740, severity: 1, Temperature: 25.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 8, hour: 17, minute: 0), latitude: 36.1699, longitude: -115.1398, severity: 2, Temperature: 22.0, Visibility: 9.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 9, hour: 21, minute: 0), latitude: 39.9526, longitude: -75.1652, severity: 3, Temperature: 8.0, Visibility: 3.0, Precipitation: 0.2, WeatherCondition: "Rain", CivilTwilight: "Night"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 10, hour: 6, minute: 0), latitude: 47.6062, longitude: -122.3321, severity: 1, Temperature: 0.0, Visibility: 0.1, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"), // Fog added to Night
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 11, hour: 13, minute: 0), latitude: 37.3382, longitude: -122.0317, severity: 2, Temperature: 17.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
//    Accident(id: UUID(), date: Accident.createDate(year: 2023, month: 12, day: 12, hour: 18, minute: 0), latitude: 34.0522, longitude: -118.2437, severity: 3, Temperature: 16.0, Visibility: 7.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Night")
//]
//
//// MARK: - 데이터 전처리
//
//// 1) 날씨 조건별, Severity별 사고 건수 집계
//// [날씨조건: [Severity: 건수]]
//let weatherSeverityCounts: [String: [Int: Int]] = {
//    var dict = [String: [Int: Int]]()
//    for accident in dummyAccidents {
//        dict[accident.WeatherCondition, default: [:]][accident.severity, default: 0] += 1
//    }
//    return dict
//}()
//
//// 2) 시간별, Severity별 사고 건수 집계
//// [시간: [Severity: 건수]]
//let hourlySeverityCounts: [Int: [Int: Int]] = {
//    var dict = [Int: [Int: Int]]()
//    let calendar = Calendar.current
//    for accident in dummyAccidents {
//        let hour = calendar.component(.hour, from: accident.date)
//        dict[hour, default: [:]][accident.severity, default: 0] += 1
//    }
//    return dict
//}()
//
//// 3) Civil Twilight 별 사고 건수 집계
//let twilightFrequency = dummyAccidents.reduce(into: [String: Int]()) { counts, accident in
//    counts[accident.CivilTwilight, default: 0] += 1
//}
//
//// MARK: - 차트용 데이터 모델
//
//struct SeverityCountData: Identifiable {
//    let id = UUID()
//    let category: String // 날씨 조건 or 시간 문자열
//    let severity: Int
//    let count: Int
//}
//
//struct HourlySeverityData: Identifiable {
//    let id = UUID()
//    let hour: Int
//    let severity: Int
//    let count: Int
//}
//
//// 4) 날씨 조건별 Severity 데이터 배열로 변환
//let weatherSeverityData: [SeverityCountData] = weatherSeverityCounts.flatMap { weather, severityDict in
//    severityDict.map { severity, count in
//        SeverityCountData(category: weather, severity: severity, count: count)
//    }
//}.sorted { $0.category < $1.category }
//
//// 5) 시간별 Severity 데이터 배열로 변환
//let hourlySeverityData: [HourlySeverityData] = hourlySeverityCounts.flatMap { hour, severityDict in
//    severityDict.map { severity, count in
//        HourlySeverityData(hour: hour, severity: severity, count: count)
//    }
//}.sorted { $0.hour < $1.hour }
//
//// 6) 시간별 총 사고 건수로 평균 계산
//let totalAccidents = hourlySeverityData.reduce(0) { $0 + $1.count }
//let totalHours = 24
//let averageAccidentsPerHour = Double(totalAccidents) / Double(totalHours)
//
//// MARK: - Severity별 색상 함수
//
//func colorForSeverity(_ severity: Int) -> Color {
//    switch severity {
//    case 1: return Color.yellow.opacity(0.5)
//    case 2: return Color.orange.opacity(0.7)
//    case 3: return Color.red.opacity(0.8)
//    case 4: return Color.red
//    default: return Color.gray
//    }
//}
//
//// MARK: - 메인 뷰
//
//struct GraphView: View {
//    @State private var selectedGraph = 0
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Picker("그래프 선택", selection: $selectedGraph) {
//                Text("Weather").tag(0)
//                Text("Civil Twilight").tag(1)
//                Text("Time").tag(2)
//            }
//            .pickerStyle(.segmented)
//            .padding()
//            
//            switch selectedGraph {
//            case 0:
//                // 날씨 조건별 Severity 누적 막대 그래프
//                VStack {
//                    Text("날씨 조건별 사고 발생 빈도")
//                        .font(.headline)
//                    
//                    Chart {
//                        ForEach(weatherSeverityData) { data in
//                            BarMark(
//                                x: .value("날씨 조건", data.category),
//                                y: .value("사고 건수", data.count),
//                                stacking: .standard
//                            )
//                            .foregroundStyle(colorForSeverity(data.severity))
//                        }
//                    }
//                    .frame(height: 300)
//                    .padding()
//                    .chartXAxis {
//                        AxisMarks(values: .automatic(desiredCount: 6)) {
//                            AxisValueLabel()
//                            AxisTick()
//                        }
//                    }
//                    .chartYAxis {
//                        AxisMarks(position: .leading)
//                    }
//                }
//                
//            case 1:
//                // Civil Twilight 파이 차트 (기존 유지)
//                VStack {
//                    Text("낮과 밤 사고 발생 빈도")
//                        .font(.headline)
//                    
//                    Chart {
//                        ForEach(twilightFrequency.sorted(by: { $0.key < $1.key }), id: \.key) { time, count in
//                            SectorMark(
//                                angle: .value("사고 건수", count),
//                                angularInset: 5.5
//                            )
//                            .foregroundStyle(by: .value("시간대", time))
//                        }
//                    }
//                    .frame(height: 300)
//                    .padding()
//                }
//                
//            case 2:
//                // 시간별 Severity 누적 막대 그래프 + 평균선
//                VStack {
//                    Text("시간별 사고 발생 빈도")
//                        .font(.headline)
//                    
//                    Chart {
//                        ForEach(hourlySeverityData) { data in
//                            BarMark(
//                                x: .value("시간", data.hour),
//                                y: .value("사고 건수", data.count),
//                                stacking: .standard
//                            )
//                            .foregroundStyle(colorForSeverity(data.severity))
//                        }
//                        
//                        RuleMark(y: .value("평균", averageAccidentsPerHour))
//                            .foregroundStyle(.red)
//                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                            .annotation(position: .top, alignment: .leading) {
//                                Text("평균: \(averageAccidentsPerHour, format: .number.precision(.fractionLength(1)))")
//                                    .font(.caption)
//                                    .foregroundColor(.red)
//                            }
//                    }
//                    .frame(height: 300)
//                    .padding()
//                    .chartXAxis {
//                        AxisMarks(values: .stride(by: 3)) {
//                            AxisValueLabel()
//                            AxisTick()
//                        }
//                    }
//                    .chartYAxis {
//                        AxisMarks(position: .leading)
//                    }
//                }
//                
//            default:
//                Text("그래프를 선택해 주세요.")
//            }
//            
//            Spacer()
//        }
//    }
//}
//
//// MARK: - 프리뷰
//
//#Preview {
//    GraphView()
//}
import SwiftUI
import Charts

struct DummyAccident: Identifiable {
    let id: UUID
    let date: Date
    let latitude: Double
    let longitude: Double
    let severity: Int
    let Temperature: Double
    let Visibility: Double
    let Precipitation: Double
    let WeatherCondition: String
    let CivilTwilight: String
    
    static func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = 0
        components.timeZone = TimeZone.current
        return Calendar.current.date(from: components) ?? Date()
    }
}

let dummyAccidents: [DummyAccident] = [
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 1, hour: 18, minute: 45), latitude: 37.7749, longitude: -122.4194, severity: 1, Temperature: 12.3, Visibility: 8.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 1, hour: 19, minute: 10), latitude: 37.7749, longitude: -122.4194, severity: 3, Temperature: 11.0, Visibility: 7.0, Precipitation: 0.1, WeatherCondition: "Clear", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 2, hour: 8, minute: 30), latitude: 34.0522, longitude: -118.2437, severity: 2, Temperature: 15.5, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Rain", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 2, hour: 9, minute: 0), latitude: 34.0522, longitude: -118.2437, severity: 4, Temperature: 14.0, Visibility: 9.0, Precipitation: 0.5, WeatherCondition: "Rain", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 3, hour: 22, minute: 0), latitude: 40.7128, longitude: -74.0060, severity: 1, Temperature: 5.1, Visibility: 2.5, Precipitation: 0.5, WeatherCondition: "Fog", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 4, hour: 7, minute: 15), latitude: 41.8781, longitude: -87.6298, severity: 1, Temperature: -2.0, Visibility: 0.5, Precipitation: 1.0, WeatherCondition: "Snow", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 5, hour: 14, minute: 0), latitude: 32.7767, longitude: -96.7970, severity: 2, Temperature: 20.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 6, hour: 19, minute: 30), latitude: 29.7604, longitude: -95.3698, severity: 3, Temperature: 18.5, Visibility: 1.0, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 7, hour: 9, minute: 0), latitude: 33.4484, longitude: -112.0740, severity: 1, Temperature: 25.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 8, hour: 17, minute: 0), latitude: 36.1699, longitude: -115.1398, severity: 2, Temperature: 22.0, Visibility: 9.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 9, hour: 21, minute: 0), latitude: 39.9526, longitude: -75.1652, severity: 3, Temperature: 8.0, Visibility: 3.0, Precipitation: 0.2, WeatherCondition: "Rain", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 10, hour: 6, minute: 0), latitude: 47.6062, longitude: -122.3321, severity: 1, Temperature: 0.0, Visibility: 0.1, Precipitation: 0.0, WeatherCondition: "Fog", CivilTwilight: "Night"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 11, hour: 13, minute: 0), latitude: 37.3382, longitude: -122.0317, severity: 2, Temperature: 17.0, Visibility: 10.0, Precipitation: 0.0, WeatherCondition: "Clear", CivilTwilight: "Day"),
    DummyAccident(id: UUID(), date: DummyAccident.createDate(year: 2023, month: 12, day: 12, hour: 18, minute: 0), latitude: 34.0522, longitude: -118.2437, severity: 3, Temperature: 16.0, Visibility: 7.0, Precipitation: 0.0, WeatherCondition: "Partly Cloudy", CivilTwilight: "Night")
]

// MARK: - 데이터 전처리

let weatherSeverityCounts: [String: [Int: Int]] = {
    var dict = [String: [Int: Int]]()
    for accident in dummyAccidents {
        dict[accident.WeatherCondition, default: [:]][accident.severity, default: 0] += 1
    }
    return dict
}()

let hourlySeverityCounts: [Int: [Int: Int]] = {
    var dict = [Int: [Int: Int]]()
    let calendar = Calendar.current
    for accident in dummyAccidents {
        let hour = calendar.component(.hour, from: accident.date)
        dict[hour, default: [:]][accident.severity, default: 0] += 1
    }
    return dict
}()

let twilightFrequency = dummyAccidents.reduce(into: [String: Int]()) { counts, accident in
    counts[accident.CivilTwilight, default: 0] += 1
}

struct SeverityCountData: Identifiable {
    let id = UUID()
    let category: String
    let severity: Int
    let count: Int
}

struct HourlySeverityData: Identifiable {
    let id = UUID()
    let hour: Int
    let severity: Int
    let count: Int
}

let weatherSeverityData: [SeverityCountData] = weatherSeverityCounts.flatMap { weather, severityDict in
    severityDict.map { severity, count in
        SeverityCountData(category: weather, severity: severity, count: count)
    }
}.sorted { $0.category < $1.category }

let hourlySeverityData: [HourlySeverityData] = hourlySeverityCounts.flatMap { hour, severityDict in
    severityDict.map { severity, count in
        HourlySeverityData(hour: hour, severity: severity, count: count)
    }
}.sorted { $0.hour < $1.hour }

let totalAccidents = hourlySeverityData.reduce(0) { $0 + $1.count }
let totalHours = 24
let averageAccidentsPerHour = Double(totalAccidents) / Double(totalHours)

func colorForSeverity(_ severity: Int) -> Color {
    switch severity {
    case 1: return Color.yellow.opacity(0.5)
    case 2: return Color.orange.opacity(0.7)
    case 3: return Color.red.opacity(0.8)
    case 4: return Color.red
    default: return Color.gray
    }
}

struct GraphView: View {
    @State private var selectedGraph = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("그래프 선택", selection: $selectedGraph) {
                Text("Weather").tag(0)
                Text("Civil Twilight").tag(1)
                Text("Time").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selectedGraph {
            case 0:
                VStack {
                    Text("날씨 조건별 사고 발생 빈도")
                        .font(.headline)
                    
                    Chart {
                        ForEach(weatherSeverityData) { data in
                            BarMark(
                                x: .value("날씨 조건", data.category),
                                y: .value("사고 건수", data.count),
                                stacking: .standard
                            )
                            .foregroundStyle(colorForSeverity(data.severity))
                        }
                    }
                    .frame(height: 300)
                    .padding()
                }
                
            case 1:
                VStack {
                    Text("낮과 밤 사고 발생 빈도")
                        .font(.headline)
                    
                    Chart {
                        ForEach(twilightFrequency.sorted(by: { $0.key < $1.key }), id: \.key) { time, count in
                            SectorMark(
                                angle: .value("사고 건수", count),
                                angularInset: 5.5
                            )
                            .foregroundStyle(by: .value("시간대", time))
                        }
                    }
                    .frame(height: 300)
                    .padding()
                }
                
            case 2:
                VStack {
                    Text("시간별 사고 발생 빈도")
                        .font(.headline)
                    
                    Chart {
                        ForEach(hourlySeverityData) { data in
                            BarMark(
                                x: .value("시간", data.hour),
                                y: .value("사고 건수", data.count),
                                stacking: .standard
                            )
                            .foregroundStyle(colorForSeverity(data.severity))
                        }
                        
                        RuleMark(y: .value("평균", averageAccidentsPerHour))
                            .foregroundStyle(.red)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .annotation(position: .top, alignment: .leading) {
                                Text("평균: \(averageAccidentsPerHour, format: .number.precision(.fractionLength(1)))")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                    }
                    .frame(height: 300)
                    .padding()
                }
                
            default:
                Text("그래프를 선택해 주세요.")
            }
            
            Spacer()
        }
    }
}

#Preview {
    GraphView()
}
