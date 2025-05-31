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
        VStack(spacing: 24){
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                Map(position: $position){
                    
                }
//                .mapControls{
//                    MapUserLocationButton()
//                }
            }
        }
    }
}

#Preview {
    MapView()
}
