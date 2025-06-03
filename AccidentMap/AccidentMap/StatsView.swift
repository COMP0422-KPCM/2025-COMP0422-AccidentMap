//
//  StatsView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/27/25.
//

import SwiftUI



struct StatsView: View {
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("시작일")
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("2025년 5월 27일")
                        .foregroundColor(Color.customOrange)
                }
                .ListStyle()
                
                HStack{
                    Text("종료일")
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("2025년 5월 27일")
                        .foregroundColor(Color.customOrange)
                }
                .ListStyle()
                
                HStack{
                    Text("위치")
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("2025년 5월 27일")
                        .foregroundColor(Color.customOrange)
                }
                .ListStyle()
                
                HStack{
                    Text("날짜")
                        .foregroundColor(Color.customGray)
                    Spacer()
                    Text("2025년 5월 27일")
                        .foregroundColor(Color.customOrange)
                }
                .ListStyle()
                
            }
            .padding(.horizontal, 16)
            
            Text("제출하기")
                .LevelStyle(backgroundColor: Color.yellow)
                .padding(.horizontal, 16)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 353, height: 400)
              .background(Color(red: 0.45, green: 0.45, blue: 0.5).opacity(0.08))
              .cornerRadius(12)
        }
    }
}

#Preview {
    StatsView()
}
