//
//  AccidentViewModel.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/2/25.
//


import Foundation
import UIKit

class AccidentViewModel: ObservableObject {
    @Published var accidentInfo: AccidentInfo?

    func analyze(image: UIImage) {
        GPTAPIManager.shared.requestScienceExplanation(for: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.accidentInfo = AccidentInfo.from(response: response)
                case .failure(let error):
                    print("❌ 에러 발생: \(error.localizedDescription)")
                }
            }
        }
    }
}