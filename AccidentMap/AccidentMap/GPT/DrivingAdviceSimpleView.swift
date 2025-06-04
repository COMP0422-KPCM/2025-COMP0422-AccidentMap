//
//  DrivingAdviceSimpleView.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/4/25.
//


import SwiftUI

struct DrivingAdviceSimpleView: View {
    @State private var advice: String = "운전 충고가 여기에 표시됩니다."
    @State private var isLoading: Bool = false
    
    // 예시용 입력
    @State private var weather: String = "맑음"
    @State private var time: String = "오전 8시"
    
    var body: some View {
        VStack(spacing: 24) {
            Text("운전 충고 요청")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading, spacing: 12) {
                TextField("날씨 입력 (예: 비)", text: $weather)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("시간 입력 (예: 밤 10시)", text: $time)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            Button(action: {
                Task {
                    isLoading = true
                    advice = ""
                    advice = await fetchDrivingAdvice(weather: weather, time: time)
                    isLoading = false
                }
            }) {
                Text("GPT에게 운전 충고 요청")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            if isLoading {
                ProgressView("GPT가 답변 중입니다...")
            } else {
                Text(advice)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    DrivingAdviceSimpleView()
}