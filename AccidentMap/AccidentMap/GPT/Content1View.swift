//
//  ContentView.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/2/25.
//

import SwiftUI

struct Content1View: View {
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var resultText = "사진을 찍어보세요!"
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .overlay(Text("이미지가 여기에 표시됩니다"))
            }

            Text(resultText)
                .padding()
                .multilineTextAlignment(.center)

            if isLoading {
                ProgressView()
            }

            HStack(spacing: 20) {
                Button("📸 사진 찍기") {
                    imageSourceType = .camera
                    showImagePicker = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("📂 사진 업로드") {
                    imageSourceType = .photoLibrary
                    showImagePicker = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: imageSourceType, image: $image, onImagePicked: { pickedImage in
                self.image = pickedImage
                self.resultText = "분석 중입니다..."
                self.isLoading = true

                GPTAPIManager.shared.requestScienceExplanation(for: pickedImage) { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let text):
                            self.resultText = text
                        case .failure(let error):
                            self.resultText = "오류 발생: \(error.localizedDescription)"
                        }
                    }
                }
            })
        }
        .padding()
    }
}
