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
                }
                
                
                DatePicker(selection: $EndDate, in: StartDate...Date(), displayedComponents: .date) {
                    Text("종료일")
                        .font(.headline)
                }
                
                
                HStack{
                    Text("위치")
                        .font(.headline)
                    Spacer()
                    Text("\(searchText)")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .padding(.vertical, 8)
                        .padding(.horizontal,11)
                        .background(Color(.systemGray5).opacity(0.7))
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

            
            VStack(spacing: 15){
                Text("검색하기")
                    .LevelStyle(backgroundColor: Color.blue)
                    .onTapGesture {
                        print(StartDate, EndDate, searchText, selectedLevels)
                    }
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(.tertiarySystemBackground))
                    GraphView()
                        .padding()
                    
                }
                .cornerRadius(12)
            }
            .padding(.horizontal, 16)

            
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $isSearching) {
//            SearchView(searchText: $searchText, isSearching: $isSearching)
        }
        
    }

}




struct MyTag {
    let label : String
    let value : Int
}


struct LevelPickView: View {
    @Binding var selectedLevels: [Int]
    let myTags: [MyTag] = [
        MyTag(label: "Level 1", value: 1),
        MyTag(label: "Level 2", value: 2),
        MyTag(label: "Level 3", value: 3),
        MyTag(label: "Level 4", value: 4),
    ]

    func binding(for tag: MyTag) -> Binding<Bool> {
        return Binding(
            get: {
                return self.selectedLevels.contains(tag.value)
            },
            set: { isOn in
                if isOn {
                    if !self.selectedLevels.contains(tag.value) {
                        self.selectedLevels.append(tag.value)
                    }
                } else {
                    self.selectedLevels = self.selectedLevels.filter { value in value != tag.value }
                }
            }
        )
    }

    var body: some View {
        ForEach(myTags, id: \.label) { tag in
            HStack {
                Toggle(tag.label, isOn: binding(for: tag))
                    .toggleStyle(CheckboxToggleStyle())
                
            }
        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn.toggle()
                }
            } label: {
                configuration.label
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.vertical, 5)
                    .padding(.horizontal,15)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(configuration.isOn ? Color.blue.opacity(0.7) : Color(.systemGray5))
                            .shadow(color: configuration.isOn ? Color.blue.opacity(0.3) : Color.clear, radius: 8, x: 0, y: 4) // 선택 시 그림자 강조
                    )
                    .foregroundColor(configuration.isOn ? Color.white : Color(.label).opacity(0.8)) // 선택 시 흰색, 미선택 시 진한 회색 글자
                    .contentShape(RoundedRectangle(cornerRadius: 18)) // 터치 영역 확장
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

#Preview {
    NavigationStack{
        StatsView()
    }
}
