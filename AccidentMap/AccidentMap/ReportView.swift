//
//  ReportView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/27/25.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        VStack(spacing: 30){
            Image("temp")
                .resizable()
                .scaledToFill()
                .frame(width: 393, height: 393)
                .clipped()
            
            VStack{
                HStack{
                    Text("날짜")
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
                
                HStack{
                    Text("날짜")
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
        }
        Spacer()
    }
}

#Preview {
    NavigationStack{
        ReportView()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("<")
                }
            }
    }
}
