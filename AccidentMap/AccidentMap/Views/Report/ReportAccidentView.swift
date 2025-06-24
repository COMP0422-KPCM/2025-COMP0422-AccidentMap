
import SwiftUI

struct ReportAccidentView: View {
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    @State private var resultText = ""
    @State private var isLoading = false
    
    var body: some View {
        List {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets())
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 100)
                        .overlay(Text("사진을 업로드 해주세요."))
                        .foregroundColor(.secondary)
                        .listRowInsets(EdgeInsets())
                }
            
                if isLoading {
                ProgressView()
                } else {
                    // 결과 출력 부분 - List 사용
                    if !resultText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading {
                     
                            Section(header: Text("분석 결과").font(.headline)) {
                                ForEach(resultText.components(separatedBy: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }, id: \.self) { line in
                                    let parts = line.components(separatedBy: ":")
                                    if parts.count >= 2 {
                                        HStack {
                                            Text(parts.first ?? "")
                                                .foregroundColor(.secondary)
                                            Spacer()
                                            Text(parts.dropFirst().joined(separator: ":"))
                                                .foregroundColor(.primary)
                                        }
                                    } else {
                                        Text(line)
                                    }
                                }
                            }
                    }
                }


                


            
            
            
        }
        .listStyle(InsetGroupedListStyle())
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
                        사고유형: \(report.사고유형)
                        심각도: \(report.심각도)
                        관련차량수: \(report.관련차량수)
                        도로종류: \(report.도로종류)
                        날씨: \(report.날씨)
                        시간대: \(report.시간대)
                        추정사고원인: \(report.추정사고원인)
                        보행자관련여부: \(report.보행자관련여부)
                        전복여부: \(report.전복여부)
                        추정충돌속도(km/h): \(report.추정충돌속도)
                        차량파손정도: \(report.차량파손정도)
                        구조요청필요여부: \(report.구조요청필요여부)
                        """
                        case .failure(let error):
                            self.resultText = "오류 발생: \(error.localizedDescription)"
                        }
                    }
                }
            })
        }
        
        VStack(spacing: 10) {

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

        
            Button(action: {

            }) {
                Label("신고 제출하기", systemImage: "exclamationmark.triangle")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            .cornerRadius(12)
            .disabled(resultText.isEmpty)
            .disabled(isLoading)
        
        }
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    ReportAccidentView()
}
