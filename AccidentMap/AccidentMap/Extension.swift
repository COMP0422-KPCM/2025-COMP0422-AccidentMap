//
//  Extention.swift
//  AccidentMap
//
//  Created by 김은정 on 5/31/25.
//

import Foundation
import SwiftUI


func DateString(in date: Date?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 dd일 HH시"
    return formatter.string(from: date ?? Date())
}

extension Color{
    static let customLightGray = Color(hex: "F1F1F3")
    static let customGray = Color(hex: "3C3C43")
    static let customDarGray = Color(hex: "C6C6C8")
    static let customGreen = Color(hex: "049707")
    static let customOrange = Color(hex: "FF9500")
    static let customYellow = Color(hex: "FFCC00")
    static let customRed = Color(hex: "FF4D00")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Text {
    
    // 여러 모디파이어를 묶어서 적용하는 함수 정의
    
    
    // 또 다른 스타일 정의 (예시)
    func headlineStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.bottom, 2)
    }
}

extension View {
    
    func LevelStyle(backgroundColor: Color = .blue) -> some View {
        self // 원래 Text 뷰 자신을 나타냅니다.
            .font(.system(size: 17))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(backgroundColor)
            .cornerRadius(12)
    }
    
    // 여러 HStack 스타일 모디파이어를 묶어서 적용하는 함수 정의
    func ListStyle() -> some View {
        self // 원래 View (여기서는 HStack) 자신을 나타냅니다.
        
            .font(.system(size: 15))
            .fontWeight(.semibold)
            .padding(.vertical, 12)
            .padding(.horizontal,16)
            .frame(maxWidth: .infinity) // 가로 길이를 부모 뷰의 최대 너비로 설정
            .background(Color.customLightGray)
            .cornerRadius(10)
        
    }
}



