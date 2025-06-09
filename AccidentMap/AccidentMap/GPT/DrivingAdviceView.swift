//
//  DrivingAdviceView.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/4/25.
//


import SwiftUI

struct DrivingAdviceView: View {
    @State private var advice: String = "운전 충고가 여기에 표시됩니다."
    @State private var isLoading: Bool = false

    // 테스트용 날씨와 시간 (실제 데이터 바인딩 가능)
    let currentWeather = "맑음"
    let currentTime = "오전 9시"
    
    var body: some View {
        VStack(spacing: 30) {
            Text("운전 조언")
                .font(.largeTitle)
                .bold()

            Text(advice)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            
            if isLoading {
                ProgressView("GPT에게 물어보는 중...")
            } else {
                Button(action: requestAdvice) {
                    Text("운전 충고 요청")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
    
    func requestAdvice() {
        isLoading = true
        advice = ""
        
        GPTManager2.shared.requestDrivingAdvice(weather: currentWeather, time: currentTime) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let gptAdvice):
                    advice = "💡 \(gptAdvice)"
                case .failure(let error):
                    advice = "❌ 오류 발생: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    DrivingAdviceView()
}
