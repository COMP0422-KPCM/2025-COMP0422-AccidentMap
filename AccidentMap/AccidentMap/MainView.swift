//
//  MainView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/27/25.
//

import SwiftUI

struct MainView: View {
    
    @State var isReport = false
    @State var isStats = false
    
    
    
    @State var Today = Date()
    
    var body: some View {
        NavigationStack{
            VStack (spacing: 15){
                ZStack (alignment: .top){
                    MapHotspotView()
                        .frame(height: 550)
                    HStack (spacing: 15){
                        NavigationLink{
                            ReportView()
                        }
                        label : {
                            HStack{
                                Image(systemName: "light.beacon.min")
                                Text("신고하기")
                            }
                        }
                        .buttonStyle(MapButton())
                        
                        NavigationLink{
                            ReportView()
                        }
                        label : {
                            HStack{
                                Image(systemName: "chart.bar")
                                Text("통계보기")
                            }
                        }
                        .buttonStyle(MapButton())
                    }
                }

                VStack(spacing: 10){
                    Text("\(DateString(in: Today)) 주의사항")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.customGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("현재 날씨는 비가와서 위험해요")
                        .LevelStyle(backgroundColor: Color.customGreen)
                    Text("현재 날씨는 비가와서 위험해요")
                        .LevelStyle(backgroundColor: Color.yellow)
                    WeatherView()
                    
                }
                .padding(.horizontal, 20)
                
                
                
                
                //                .padding(.top, 0)
                //                .padding(.bottom, 8)
                //                .frame(width: 393, alignment: .topTrailing)
                
            }

            Spacer()
        }

        
        
    }
    
    
}

#Preview {
    NavigationStack{
        MainView()
    }
}
