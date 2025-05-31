//
//  MapView.swift
//  AccidentMap
//
//  Created by 김은정 on 5/31/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
                Map(position: $position){
                    UserAnnotation()
                    
                }
//                .ignoresSafeArea()
                .toolbarBackground(.hidden, for: .navigationBar)

                .mapControls{
                    MapUserLocationButton()
                }
    }
}

#Preview {
    MapView()
}
