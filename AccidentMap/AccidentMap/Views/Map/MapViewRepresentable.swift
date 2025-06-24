import SwiftUI
import MapKit

struct MapViewSwiftUI: View {
    @Binding var region: MKCoordinateRegion
    let hotspots: [Hotspot]
    @Binding var selectedHotspot: Hotspot?
    @Binding var isSheetPresented: Bool
    @Binding var sheetDetent: CGFloat

    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: [.all],
            showsUserLocation: true,
            annotationItems: hotspots) { hotspot in

            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: hotspot.lat, longitude: hotspot.lng)) {
                Button {
                    selectedHotspot = hotspot
                    isSheetPresented = true
                    sheetDetent = 0.5
                    withAnimation {
                        region.center = CLLocationCoordinate2D(latitude: hotspot.lat, longitude: hotspot.lng)
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        Image(systemName: "car.side.rear.and.collision.and.car.side.front")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
