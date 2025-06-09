//
//  UIKitMapView.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/1/25.
//


//import SwiftUI
//import MapKit
//
//struct UIKitMapView: UIViewRepresentable {
//    @Binding var region: MKCoordinateRegion
//    @Binding var hotspots: [Hotspot]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
//        
//        mapView.showsCompass = true
//        mapView.showsScale = true
//        mapView.isRotateEnabled = true
//
//        // 내 위치 버튼 (MKUserTrackingButton) 추가
//        let trackingButton = MKUserTrackingButton(mapView: mapView)
//        trackingButton.frame = CGRect(x: 10, y: 50, width: 40, height: 40)
//        trackingButton.layer.backgroundColor = UIColor.white.cgColor
//        trackingButton.layer.cornerRadius = 5
//        trackingButton.layer.shadowColor = UIColor.black.cgColor
//        trackingButton.layer.shadowOpacity = 0.3
//        trackingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
//        trackingButton.layer.shadowRadius = 2
//        mapView.addSubview(trackingButton)
//
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.setRegion(region, animated: true)
//
//        // 기존 어노테이션 모두 제거
//        uiView.removeAnnotations(uiView.annotations)
//
//        // 핫스팟 어노테이션 추가
//        let annotations = hotspots.map { hotspot -> MKPointAnnotation in
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: hotspot.lat, longitude: hotspot.lng)
//            annotation.title = "사고 건수: \(hotspot.count)건"
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
//        var parent: UIKitMapView
//
//        init(_ parent: UIKitMapView) {
//            self.parent = parent
//        }
//    }
//}
