
import SwiftUI

struct Content1View: View {
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var resultText = "교통사고 사진을 찍어주세요.\n AI가 분석하여 신고합니다."
    @State private var isLoading = false
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 20) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 393, height: 393)
                        .clipped()
                        .cornerRadius(20)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .overlay(Text("이미지가 여기에 표시됩니다"))
                        .cornerRadius(20)
                }
                
                Text(resultText)
                    .padding()
                    .multilineTextAlignment(.center)
                if isLoading {
                    ProgressView()
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(resultText.components(separatedBy: "\n"), id: \.self) { line in
                            if !line.trimmingCharacters(in: .whitespaces).isEmpty {
                                HStack {
                                    Text(line.components(separatedBy: ":").first ?? "")
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(line.components(separatedBy: ":").dropFirst().joined(separator: ":"))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .padding()
                }
                HStack{
                    Text("날짜")
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("2025년 5월 27일")
                        .foregroundColor(Color.customOrange)
                }
                .ListStyle()
                
                if isLoading {
                    ProgressView()
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        imageSourceType = .camera
                        showImagePicker = true
                    }) {
                        Label("사진 찍기", systemImage: "camera")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .controlSize(.large)
                    .cornerRadius(12)
                    
                    Button(action: {
                        imageSourceType = .photoLibrary
                        showImagePicker = true
                    }) {
                        Label("사진 업로드", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .controlSize(.large)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                Spacer()
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
                                let report = parseAccidentReport(from: text)
                                self.resultText = """
                            사고유형: \(report.사고유형),
                            심각도: \(report.심각도),
                            관련차량수: \(report.관련차량수),
                            도로종류: \(report.도로종류),
                            날씨: \(report.날씨),
                            시간대: \(report.시간대),
                            추정사고원인: \(report.추정사고원인),
                            보행자관련여부: \(report.보행자관련여부),
                            전복여부: \(report.전복여부),
                            추정충돌속도(km/h): \(report.추정충돌속도),
                            차량파손정도: \(report.차량파손정도),
                            구조요청필요여부: \(report.구조요청필요여부),
                            """
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
}

#Preview {
    Content1View()
}
