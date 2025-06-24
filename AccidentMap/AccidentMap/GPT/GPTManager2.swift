//
//  GPTManager2.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/4/25.
//


import Foundation

// 2 for interation
class GPTManager2 {
    static let shared = GPTManager2()
    
    private let apiKey = "" // 🔐 OpenAI API Key 입력
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func requestDrivingAdvice(weather: String, time: String, completion: @escaping (Result<String, Error>) -> Void) {
        let prompt = """
        지금 운전자가 운전 중인데, 현재 날씨는 \(weather)이고, 시간은 \(time)이야.
        이 상황에 맞는 안전 운전 충고를 한 문장으로 간결하고 자연스럽게 해줘. 존댓말로 친근하게.귀여운 의성어도 추가해도되고 이모티콘도 ok.근데 날씨가 안좋고 밤이라면 경고도 확실하게 해줘.        예시: 비가 주륵주륵오는 날. 밤이기도하니까 꼭 안전운전하세요!.
        """

        let payload: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "max_tokens": 100,
            "temperature": 0.7
        ]
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1)))
                return
            }
            
            if let raw = String(data: data, encoding: .utf8) {
                print("🧾 운전 충고 응답 원문:\n\(raw)")
            }
            
            guard let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = responseJSON["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion(.failure(NSError(domain: "APIResponse", code: -2)))
                return
            }
            
            completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
        }.resume()
    }
}
import SwiftUI

func fetchDrivingAdvice(weather: String, time: String) async -> String {
    await withCheckedContinuation { continuation in
        GPTManager2.shared.requestDrivingAdvice(weather: weather, time: time) { result in
            switch result {
            case .success(let advice):
                continuation.resume(returning: advice)
            case .failure(let error):
                continuation.resume(returning: "❌ 오류 발생: \(error.localizedDescription)")
            }
        }
    }
}
