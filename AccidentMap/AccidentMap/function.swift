//
//  function.swift
//  AccidentMap
//
//  Created by 문재윤 on 5/29/25.
//
import Foundation
import Combine

// 공통 응답 모델
struct Hotspot: Codable, Identifiable {
    let id: Int
    let lat: Double
    let lng: Double
    let count: Int
}

struct Trend: Codable {
    let date: String
    let count: Int
}

struct TrendResponse: Codable {
    let region: String
    let trend: [Trend]
}

struct RiskResponse: Codable {
    let riskLevel: String
    let message: String
}

struct ReportResponse: Codable {
    let result: String
    let reportId: Int
}

struct SettingsResponse: Codable {
    let result: String
}

struct ReportApprovalResponse: Codable {
    let result: String
}

class APIService {
    static let shared = APIService()
    private let baseURL = "https://yourapi.com"

    // 1. GET /api/hotspots
    func fetchHotspots(lat: Double? = nil, lng: Double? = nil, radius: Int? = nil, completion: @escaping (Result<[Hotspot], Error>) -> Void) {
        var components = URLComponents(string: "\(baseURL)/api/hotspots")!
        components.queryItems = [
            lat.map { URLQueryItem(name: "lat", value: "\($0)") },
            lng.map { URLQueryItem(name: "lng", value: "\($0)") },
            radius.map { URLQueryItem(name: "radius", value: "\($0)") }
        ].compactMap { $0 }

        guard let url = components.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([Hotspot].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // 2. GET /api/trends
    func fetchTrends(region: String, startDate: String, endDate: String, completion: @escaping (Result<TrendResponse, Error>) -> Void) {
        var components = URLComponents(string: "\(baseURL)/api/trends")!
        components.queryItems = [
            URLQueryItem(name: "region", value: region),
            URLQueryItem(name: "startDate", value: startDate),
            URLQueryItem(name: "endDate", value: endDate)
        ]

        guard let url = components.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TrendResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // 3. POST /api/warnings/predict
    func predictRisk(route: [[String: Double]], datetime: String, weather: String, completion: @escaping (Result<RiskResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/warnings/predict") else { return }

        let body: [String: Any] = [
            "route": route,
            "datetime": datetime,
            "weather": weather
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RiskResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // 4. POST /api/reports
    func reportAccident(lat: Double, lng: Double, datetime: String, description: String, imageUrl: String, completion: @escaping (Result<ReportResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/reports") else { return }

        let body: [String: Any] = [
            "lat": lat,
            "lng": lng,
            "datetime": datetime,
            "description": description,
            "imageUrl": imageUrl
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ReportResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // 5. PUT /api/admin/settings
    func updateAdminSettings(alertRadius: Int, riskThreshold: Double, completion: @escaping (Result<SettingsResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/admin/settings") else { return }

        let body: [String: Any] = [
            "alertRadius": alertRadius,
            "riskThreshold": riskThreshold
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        // 인증이 필요한 경우 헤더에 토큰 추가
        // request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(SettingsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
