import SwiftUI

struct AccidentInfoView: View {
    @StateObject private var viewModel = AccidentViewModel()
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 16) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            Button("이미지 선택") {
                showImagePicker = true
            }

            if let info = viewModel.accidentInfo {
                List {
                    Text("사고유형: \(info.사고유형)")
                    Text("심각도: \(info.심각도)")
                    Text("관련차량수: \(info.관련차량수)")
                    Text("도로종류: \(info.도로종류)")
                    Text("날씨: \(info.날씨)")
                    Text("시간대: \(info.시간대)")
                    Text("추정사고원인: \(info.추정사고원인)")
                    Text("보행자관련여부: \(info.보행자관련여부)")
                    Text("전복여부: \(info.전복여부)")
                    Text("추정충돌속도: \(info.추정충돌속도)")
                    Text("차량파손정도: \(info.차량파손정도)")
                    Text("구조요청필요여부: \(info.구조요청필요여부)")
                }
            }
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, image: $selectedImage) { image in
                viewModel.analyze(image: image)
            }
        }
    }
}

#Preview {
    AccidentInfoView()
}
