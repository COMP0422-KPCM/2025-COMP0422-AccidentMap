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

    var body: some View {
        VStack{
            List{
                DatePicker(selection: $StartDate, in: ...Date(), displayedComponents: .date) {
                    Text("시작일")
                        .foregroundColor(Color.customGray)
                }
                
                DatePicker(selection: $StartDate, in: StartDate...Date(), displayedComponents: .date) {
                    Text("종료일")
                        .foregroundColor(Color.customGray)
                }
                
                
                HStack{
                    Text("위치")
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
                LevelPickView()
            }
            
            VStack(spacing: 20){
                Text("검색하기")
                    .LevelStyle(backgroundColor: Color.blue)
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
    @State var selectedTopics : [String] = ["Level 1", "Level 2", "Level 3","Level 4"]
    
    let myTags : [MyTag] =  [
        MyTag(label: "Level 1", value: 1),
        MyTag(label: "Level 2", value: 2),
        MyTag(label: "Level 3", value: 3),
        MyTag(label: "Level 4", value: 4),
        
    ]
    
    func binding(for key: String) -> Binding<Bool> {
        return Binding(
            get: {
                return self.selectedTopics.contains(key)
            }
            , set: {
                if($0 == false){
                    self.selectedTopics = self.selectedTopics.filter{topic in topic != key}
                } else{
                    self.selectedTopics.append(key)
                }
            }
        )
    }
    
    var body: some View {
        ForEach(myTags.map{$0.label}, id : \.self){el in
            HStack{
                Toggle(el, isOn: binding(for:el))
                    .toggleStyle(CheckboxToggleStyle())
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
