//
//  gptmanager.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/2/25.
//

import Foundation
import UIKit

class GPTAPIManager {
    static let shared = GPTAPIManager()
    
    private let apiKey = "" // 🔐 여기에 OpenAI API Key 입력
    private let endpoint = "https://api.openai.com/v1/chat/completions"

    func requestScienceExplanation(for image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completion(.failure(NSError(domain: "ImageConversion", code: -1)))
            return
        }

        let base64String = imageData.base64EncodedString()
        let imageUrl = "data:image/jpeg;base64,\(base64String)"
        let promptText = """
        이미지를 보고 적어줘
        사고 데이터를 이미지를 보고 적어줘. 혹시 이미지 분석이 힘들어도 적어주라. 키 값은 꼭 필요하니까 무조건 적어줘 부탁이야. 잘 모르겠는거 그런거없어.에츨해서라도 더미데이터 만들어 모르겠으면.
        각 항목은 `키: 값` 형태로 한 줄씩 작성하고, 추정인 경우 값 뒤에 (추정)이라고 명시해줘.
        ,도 꼭 추가해줘.
        설명이나 해석 없이 아래 항목만 딱 나열해줘:

        사고유형:  
        심각도:  
        관련차량수:  
        도로종류:  
        날씨:  
        시간대:  
        추정사고원인:  
        보행자관련여부:  
        전복여부:  
        추정충돌속도(km/h):  
        차량파손정도:  
        구조요청필요여부:
        
        출력예시:
        사고유형: 후방 추돌,
        심각도: 중간  ,
        관련차량수: 3  ,
        도로종류: 고속도로  ,
        날씨: 맑음 (추정)  ,
        시간대: 주간  ,
        추정사고원인: 과속 ,  
        보행자관련여부: 없음 ,  
        전복여부: 없음  ,
        추정충돌속도(km/h): 70 (추정) , 
        차량파손정도: 중간  ,
        구조요청필요여부: 없음 ,
        
        이런식으로 적어라. 이미지 인식좀 잘해봐 제대로 개빡치게 하지말고
        """
        
        let payload: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "image_url",
                            "image_url": ["url": imageUrl]
                        ],
                        [
                            "type": "text",

                            "text": promptText
                        ]
                    ]
                ]
            ],
            "max_tokens": 500
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

            // ✅ 여기가 바로 print를 넣을 자리야!
            if let raw = String(data: data, encoding: .utf8) {
                print("🧾 GPT 응답 원문:\n\(raw)")
            }

            guard let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = responseJSON["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion(.failure(NSError(domain: "APIResponse", code: -2)))
                return
            }

            completion(.success(content))
        }.resume()
    }
}
