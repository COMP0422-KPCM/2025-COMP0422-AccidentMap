//
//  Main.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/1/25.
//

import Foundation
import MapKit

class MapHotspotViewModel: ObservableObject {
    @Published var hotspots: [Hotspot] = []
    
    func fetchHotspots(lat: Double, lng: Double) {
        APIService.shared.fetchHotspots(lat: lat, lng: lng, radius: 300) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.hotspots = data
                case .failure(let error):
                    print("Hotspot fetch error: \(error)")
                }
            }
        }
    }
}



import SwiftUI
import MapKit

struct MapHotspotView: View {
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var viewModel: MapHotspotViewModel
    @State private var selectedHotspot: Hotspot? = nil
    @State private var mapView: MKMapView?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5, longitude: 127.0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var isSheetPresented = false
    @State private var addressText = ""
    @StateObject private var searchVM = SearchCompleterViewModel()
    @State private var searchText = ""
    @State private var isSearchResultsVisible = false
    @State private var isSearchButtonVisible = false
    @State private var lastUserLocation: CLLocationCoordinate2D? = nil
    
    init(viewModel: MapHotspotViewModel = MapHotspotViewModel()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            MapViewRepresentable(
                region: $region,
                hotspots: viewModel.hotspots,
                selectedHotspot: $selectedHotspot,
                isSheetPresented: $isSheetPresented,
                onMapViewCreated: { createdMapView in
                    DispatchQueue.main.async {
                        self.mapView = createdMapView
                    }
                },
                sheetDetent: .constant(0)
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                TextField("장소 또는 주소 검색", text: $searchText, onEditingChanged: { editing in
                    isSearchResultsVisible = editing
                })
                .padding(8)
                .background(Color.white)
                .cornerRadius(10)
                .padding([.top, .horizontal])
                .onChange(of: searchText) { newValue in
                    searchVM.updateSearchQuery(newValue)
                }
                
                if isSearchResultsVisible && !searchVM.searchResults.isEmpty {
                    List(searchVM.searchResults, id: \.self) { result in
                        VStack(alignment: .leading) {
                            Text(result.title).bold()
                            Text(result.subtitle).font(.caption).foregroundColor(.gray)
                        }
                        .onTapGesture {
                            searchLocation(for: result)
                            searchText = result.title
                            isSearchResultsVisible = false
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(maxHeight: 200)
                    .padding(.horizontal)
                    .background(Color.white)
                }
                
                // ✅ [현재 지도에서 검색] 버튼 추가 (아직 기능 없이 UI만)
                Button(action: {
                    // 여기에 검색 기능 넣을 수 있음
                }) {
                    Text("현재 지도에서 검색")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                
                
                Spacer()
            }
            .padding(.top, 35)
        }
        .sheet(isPresented: $isSheetPresented) {
            VStack(spacing: 20) {
                if let hotspot = selectedHotspot {
                    Text("🚗 사고 다발 지역")
                        .font(.headline)
                    Text("위도: \(hotspot.lat)")
                    Text("경도: \(hotspot.lng)")
                    Text("사고 건수: \(hotspot.count)건")
                } else {
                    Text("사고 지역을 선택하세요")
                        .foregroundColor(.gray)
                }
            }
            .presentationDetents([.fraction(0.2), .fraction(0.5)])
            .presentationDragIndicator(.visible)
            .padding()
        }
        .onReceive(locationManager.$currentLocation) { location in
            guard let location = location else { return }
            region.center = location.coordinate
            viewModel.fetchHotspots(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        }
    }
    
    // 주소 → 좌표 변환
    func searchAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let coordinate = placemarks?.first?.location?.coordinate {
                completion(coordinate)
            } else {
                print("주소 검색 실패: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    func searchLocation(for result: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                print("검색 실패: \(error?.localizedDescription ?? "알 수 없음")")
                return
            }
            region.center = coordinate
            // 원하면 여기서 viewModel.fetchHotspots(...) 호출 가능
        }
    }
}





class MockMapHotspotViewModel: MapHotspotViewModel {
    override init() {
        super.init()
        self.hotspots = [
            Hotspot(id: 1, lat: 37.3351, lng: -122.0092, count: 8),   // 북서쪽
            Hotspot(id: 2, lat: 37.3340, lng: -122.0088, count: 12),  // 남동쪽
            Hotspot(id: 3, lat: 37.3330, lng: -122.0093, count: 5)    // 정중앙에서 서쪽
        ]
    }
    
}

struct MapHotspotView_Previews: PreviewProvider {
    static var previews: some View {
        MapHotspotView(viewModel: MockMapHotspotViewModel())
    }
}


