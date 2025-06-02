//
//  MapView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/31/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    @Namespace var mapScope
    
    @State private var position: MapCameraPosition = .automatic
    
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            Map(scope: mapScope)
            MapUserLocationButton(scope: mapScope)
                .frame(width: 43)
                .background(.white)
                .cornerRadius(100)
                .padding()

            
        }
        .mapScope(mapScope)
    

//                .ignoresSafeArea()
                .toolbarBackground(.hidden, for: .navigationBar)

    }
}

#Preview {
    MapView()
}
