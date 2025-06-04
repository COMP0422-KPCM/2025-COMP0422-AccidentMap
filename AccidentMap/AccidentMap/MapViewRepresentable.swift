//
//  MapViewRepresentable.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/1/25.
//
//import SwiftUI
//import MapKit
//
//// MKMapView를 SwiftUI에서 사용하기 위한 래퍼
//struct MapViewRepresentable: UIViewRepresentable {
//    @Binding var region: MKCoordinateRegion
//    let hotspots: [Hotspot]
//    @Binding var selectedHotspot: Hotspot?
//    @Binding var isSheetPresented: Bool
//    let onMapViewCreated: (MKMapView) -> Void
//    @Binding var sheetDetent: CGFloat // <- 이 줄 추가
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .none // .follow에서 .none으로 변경
//        
//        // mapView 생성 즉시 콜백 호출
//        onMapViewCreated(mapView)
//        
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        if abs(uiView.region.center.latitude - region.center.latitude) > 0.0001 ||
//           abs(uiView.region.center.longitude - region.center.longitude) > 0.0001 {
//            uiView.setRegion(region, animated: true)
//        }
//        
//        // 기존 annotation 제거 (사용자 위치 제외)
//        let existingAnnotations = uiView.annotations.filter { !($0 is MKUserLocation) }
//        uiView.removeAnnotations(existingAnnotations)
//        
//        // 새로운 hotspot annotation 추가
//        let annotations = hotspots.map { hotspot -> MKPointAnnotation in
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: hotspot.lat, longitude: hotspot.lng)
//            annotation.title = "사고 다발 지역"
//            annotation.subtitle = "사고 건수: \(hotspot.count)건"
//            return annotation
//        }
//        uiView.addAnnotations(annotations)
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapViewRepresentable
//        
//        init(_ parent: MapViewRepresentable) {
//            self.parent = parent
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard !(annotation is MKUserLocation) else { return nil }
//            
//            let identifier = "HotspotAnnotation"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            
//            if annotationView == nil {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true
//            } else {
//                annotationView?.annotation = annotation
//            }
//            
//            // 커스텀 이미지 설정
//            let size = CGSize(width: 30, height: 30)
//            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//            
//            let circle = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
//            UIColor.white.setFill()
//            circle.fill()
//            
//            // 테두리 추가
//            UIColor.lightGray.setStroke()
//            circle.lineWidth = 1
//            circle.stroke()
//            
//            let image = UIImage(systemName: "car.side.rear.and.collision.and.car.side.front")?
//                .withTintColor(.red, renderingMode: .alwaysOriginal)
//            image?.draw(in: CGRect(x: 6, y: 6, width: 18, height: 18))
//            
//            annotationView?.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return annotationView
//        }
//        
//        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            guard let annotation = view.annotation,
//                  !(annotation is MKUserLocation) else { return }
//
//            // hotspot 찾기
//            if let hotspot = parent.hotspots.first(where: {
//                abs($0.lat - annotation.coordinate.latitude) < 0.0001 &&
//                abs($0.lng - annotation.coordinate.longitude) < 0.0001
//            }) {
//                parent.selectedHotspot = hotspot
//                parent.isSheetPresented = true
//                
//                // 지도 중심을 해당 핫스팟 위치로 이동
//                DispatchQueue.main.async {
//                    self.parent.region.center = CLLocationCoordinate2D(latitude: hotspot.lat, longitude: hotspot.lng)
//                }
//                self.parent.sheetDetent = 0.5
//            }
//        }
//    }
//}


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
