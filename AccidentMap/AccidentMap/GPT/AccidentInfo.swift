//
//  AccidentInfo.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/2/25.
//


import Foundation

struct AccidentInfo: Identifiable {
    let id = UUID()
    let 사고유형: String
    let 심각도: String
    let 관련차량수: String
    let 도로종류: String
    let 날씨: String
    let 시간대: String
    let 추정사고원인: String
    let 보행자관련여부: String
    let 전복여부: String
    let 추정충돌속도: String
    let 차량파손정도: String
    let 구조요청필요여부: String

    static func from(response: String) -> AccidentInfo? {
        var dict: [String: String] = [:]

        let lines = response.split(separator: "\n")
        for line in lines {
            let components = line.split(separator: ":", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
            guard components.count == 2 else { continue }
            let key = components[0]
            let value = components[1].trimmingCharacters(in: CharacterSet(charactersIn: ", "))

            dict[key] = value
        }

        return AccidentInfo(
            사고유형: dict["사고유형"] ?? "없음",
            심각도: dict["심각도"] ?? "없음",
            관련차량수: dict["관련차량수"] ?? "없음",
            도로종류: dict["도로종류"] ?? "없음",
            날씨: dict["날씨"] ?? "없음",
            시간대: dict["시간대"] ?? "없음",
            추정사고원인: dict["추정사고원인"] ?? "없음",
            보행자관련여부: dict["보행자관련여부"] ?? "없음",
            전복여부: dict["전복여부"] ?? "없음",
            추정충돌속도: dict["추정충돌속도(km/h)"] ?? "없음",
            차량파손정도: dict["차량파손정도"] ?? "없음",
            구조요청필요여부: dict["구조요청필요여부"] ?? "없음"
        )
    }
}