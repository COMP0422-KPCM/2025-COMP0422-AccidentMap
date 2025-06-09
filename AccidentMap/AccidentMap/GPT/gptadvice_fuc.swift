//
//  Untitled.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/4/25.
//
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
