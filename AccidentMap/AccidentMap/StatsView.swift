//
//  StatsView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/27/25.
//

import SwiftUI

struct StatsView: View {
    @State private var StartDate = Date()
    @State private var EndDate = Date()
    
    @State var searchText = "대구광역시 북구 대현동"
    @State var isSearching = false
    
    @State var selectedLevels : [Int] = []

    var body: some View {
        VStack{
            List{
                DatePicker(selection: $StartDate, in: ...Date(), displayedComponents: .date) {
                    Text("시작일")
                        .font(.headline)
                        .foregroundColor(Color.customGray)
                }
                
                
                DatePicker(selection: $StartDate, in: StartDate...Date(), displayedComponents: .date) {
                    Text("종료일")
                        .font(.headline)
                        .foregroundColor(Color.customGray)
                }
                
                
                HStack{
                    Text("위치")
                        .font(.headline)
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("\(searchText)")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .padding(.vertical, 8)
                        .padding(.horizontal,11)
                        .background(Color.customLightGray)
                        .cornerRadius(6)
                        .onTapGesture {
                            isSearching = true
                        }
                }
                
            }
            .frame(height: 170)
            .scrollContentBackground(.hidden)
            HStack (spacing: 10){
                LevelPickView(selectedLevels: $selectedLevels)
            }

            
            VStack(spacing: 20){
                Text("검색하기")
                    .LevelStyle(backgroundColor: Color.blue)
                    .onTapGesture {
                        print(StartDate, EndDate, searchText, selectedLevels)
                    }
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                    GraphView()
                        .padding()
                    
                }
                .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            
        }
        .background(Color.customLightGray)
        .sheet(isPresented: $isSearching) {
            SearchView(searchText: $searchText, isSearching: $isSearching)
        }
        
    }

}




struct MyTag {
    let label : String
    let value : Int
}


struct LevelPickView: View {
    // 1. Binding 타입을 [Int]로 변경합니다.
    @Binding var selectedLevels: [Int] // 이름을 selectedLevels로 변경하여 더 명확하게 표현

    let myTags: [MyTag] = [
        MyTag(label: "Level 1", value: 1),
        MyTag(label: "Level 2", value: 2),
        MyTag(label: "Level 3", value: 3),
        MyTag(label: "Level 4", value: 4),
    ]

    // 2. 바인딩 함수를 MyTag 객체를 받거나, value(Int)를 받도록 수정합니다.
    // 여기서는 MyTag 객체를 받아서 label은 표시용으로, value는 데이터 저장용으로 사용합니다.
    func binding(for tag: MyTag) -> Binding<Bool> {
        return Binding(
            get: {
                // 3. 배열에 해당 tag의 value가 포함되어 있는지 확인합니다.
                return self.selectedLevels.contains(tag.value)
            },
            set: { isOn in
                if isOn {
                    // 4. 토글이 켜지면 selectedLevels 배열에 해당 tag의 value를 추가합니다.
                    // 중복 추가를 방지하기 위해 이미 없는 경우에만 추가합니다.
                    if !self.selectedLevels.contains(tag.value) {
                        self.selectedLevels.append(tag.value)
                    }
                } else {
                    // 5. 토글이 꺼지면 selectedLevels 배열에서 해당 tag의 value를 제거합니다.
                    self.selectedLevels = self.selectedLevels.filter { value in value != tag.value }
                }
            }
        )
    }

    var body: some View {
        // 6. ForEach를 myTags 배열 자체를 순회하도록 변경합니다.
        ForEach(myTags, id: \.label) { tag in // id는 label 또는 value 사용 가능 (여기서는 label)
            HStack {
                // 7. Toggle의 텍스트는 tag.label을 사용하고, isOn 바인딩에는 수정된 binding 함수에 tag 객체를 전달합니다.
                Toggle(tag.label, isOn: binding(for: tag))
                    .toggleStyle(CheckboxToggleStyle()) // CheckboxToggleStyle는 별도로 정의되어 있다고 가정합니다.
            }
        }
    }
}



struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .foregroundColor(configuration.isOn ? Color.white : Color.black)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .padding(.vertical, 5)
                .padding(.horizontal,15)
                .background(configuration.isOn ? Color.blue : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
        })
        
    }
}

#Preview {
    NavigationStack{
        StatsView()
    }
}
