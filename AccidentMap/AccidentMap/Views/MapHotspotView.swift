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
    @State var Today = Date()
    @State private var sheetDetent: CGFloat = 0.0
    
    init(viewModel: MapHotspotViewModel = MapHotspotViewModel()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
        ZStack {
            MapViewSwiftUI(
                           region: $region,
                           hotspots: viewModel.hotspots,
                           selectedHotspot: $selectedHotspot,
                           isSheetPresented: $isSheetPresented,
                           sheetDetent: $sheetDetent
                       )
            .mapControls {
                MapUserLocationButton()
                    .padding(.top, 200)
            }
            VStack(spacing: 10) {
                TextField("장소 또는 주소 검색", text: $searchText, onEditingChanged: { editing in
                    isSearchResultsVisible = editing
                })
                .padding(11)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 4)
                .onChange(of: searchText) { newValue in
                    searchVM.updateSearchQuery(newValue)
                }
                .padding(.trailing, 40)
                
                
                if isSearchResultsVisible && !searchVM.searchResults.isEmpty {
                    if isSearchResultsVisible && !searchVM.searchResults.isEmpty {
                 
                        VStack {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(searchVM.searchResults, id: \.self) { result in
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(result.title)
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                            Text(result.subtitle)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 16)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            searchLocation(for: result)
                                            searchText = result.title
                                            isSearchResultsVisible = false
                                        }
                                        
                                        Divider()
                                            .padding(.leading, 16)
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                )
                                .padding(.horizontal)
                            }

                            .transition(.opacity)
                        }
                     Spacer()
                    }
                } else {
                    HStack (spacing: 15){
                        NavigationLink{
                            Content1View()
                        }
                        label : {
                            HStack{
                                Image(systemName: "light.beacon.min")
                                Text("신고하기")
                            }
                        }
                        .buttonStyle(MapButton())
                        
                        NavigationLink{
                            Content1View()
                        }
                        label : {
                            HStack{
                                Image(systemName: "chart.bar")
                                Text("통계보기")
                            }
                        }
                        .buttonStyle(MapButton())
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
                    
                    
                    VStack(spacing: 8) {
                        if isSheetPresented == false {
                            // 헤더
                            HStack {
                                Text("\(DateString(in: Today)) 주의사항")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.top, 6)
                            
                            // 내용
                            VStack(alignment: .leading, spacing: 8) {
                                NoticeMessageView(
                                    message: "현재 날씨는 비가 와서 위험해요",
                                    backgroundColor: .green.opacity(0.2)
                                )
                                
                                NoticeMessageView(
                                    message: "강풍 주의보가 발효 중입니다",
                                    backgroundColor: .yellow.opacity(0.2)
                                )
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("🚗 사고 다발 지역")
                                        .font(.headline)
                                    Spacer()
                                    Button(action: {
                                        isSheetPresented = false
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                if let hotspot = selectedHotspot {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("위도: \(hotspot.lat)")
                                        Text("경도: \(hotspot.lng)")
                                        Text("사고 건수: \(hotspot.count)건")
                                    }
                                    .font(.body)
                                    .foregroundColor(.primary)
                                } else {
                                    Text("사고 지역을 선택하세요")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                    .padding()
                }
            }
            
        }
        .interactiveDismissDisabled(true)
        .onReceive(locationManager.$currentLocation) { location in
            guard let location = location else { return }
            region.center = location.coordinate
            viewModel.fetchHotspots(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        }
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


struct NoticeMessageView: View {
    let message: String
    let backgroundColor: Color

    var body: some View {
        Text(message)
            .font(.callout)
            .foregroundColor(.primary)
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(12)
    }
}
