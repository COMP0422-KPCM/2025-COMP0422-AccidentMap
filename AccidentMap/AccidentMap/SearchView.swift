//
//  SearchView.swift
//  AccidentMap
//
//  Created by 김은정 on 6/4/25.
//

import SwiftUI
import MapKit


//struct SearchView: View {
//    @StateObject private var locationManager = LocationManager()
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.5, longitude: 127.0),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    
//    
//    @State private var searchText = ""
//    
//    @StateObject private var searchVM = SearchCompleterViewModel()
//    @State private var isSearchResultsVisible = false
//    
//    
//    @State private var addressText = ""
//    @State private var isSearchButtonVisible = false
//
//    
//    
//    var body: some View {
//                
//        VStack(spacing: 10) {
//            TextField("장소 또는 주소 검색", text: $searchText, onEditingChanged: { editing in
//                isSearchResultsVisible = editing
//            })
//            .padding(8)
//            .background(Color.white)
//            .cornerRadius(10)
//            .padding([.top, .horizontal])
//            .onChange(of: searchText) { newValue in
//                searchVM.updateSearchQuery(newValue)
//            }
//            
//            if isSearchResultsVisible && !searchVM.searchResults.isEmpty {
//                List(searchVM.searchResults, id: \.self) { result in
//                    VStack(alignment: .leading) {
//                        Text(result.title).bold()
//                        Text(result.subtitle).font(.caption).foregroundColor(.gray)
//                    }
//                    .onTapGesture {
//                        searchLocation(for: result)
//                        searchText = result.title
//                        isSearchResultsVisible = false
//                    }
//                }
//                .listStyle(PlainListStyle())
//                .frame(maxHeight: 200)
//                .padding(.horizontal)
//                .background(Color.white)
//            }
//
//        }
//
//        
//        
//    }
//    
//    // 주소 → 좌표 변환
//    func searchAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address) { placemarks, error in
//            if let coordinate = placemarks?.first?.location?.coordinate {
//                completion(coordinate)
//            } else {
//                print("주소 검색 실패: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//            }
//        }
//    }
//    func searchLocation(for result: MKLocalSearchCompletion) {
//        let searchRequest = MKLocalSearch.Request(completion: result)
//        let search = MKLocalSearch(request: searchRequest)
//        
//        search.start { response, error in
//            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
//                print("검색 실패: \(error?.localizedDescription ?? "알 수 없음")")
//                return
//            }
//            region.center = coordinate
//            // 원하면 여기서 viewModel.fetchHotspots(...) 호출 가능
//        }
//    }
//    
//}



import SwiftUI
import MapKit

struct SearchView: View {
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
    @State private var isSearchResultsVisible = false
    @State private var isSearchButtonVisible = false
    @State private var lastUserLocation: CLLocationCoordinate2D? = nil
    
    @Binding var searchText: String
    @Binding var isSearching: Bool

    
    init(viewModel: MapHotspotViewModel = MapHotspotViewModel(),  searchText: Binding<String>, isSearching: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _searchText = searchText
        _isSearching = isSearching
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
                    Text("확인")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .onTapGesture {
                            isSearching = false
                        }
                }
                
                
                
                Spacer()
            }
            
            .padding(.top, 35)
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




#Preview {
    // @State 변수를 선언하고 그 변수의 Binding을 전달합니다.
    @State var previewSearchText = ""
    @State var isSearching = true
    return SearchView(searchText: $previewSearchText, isSearching: $isSearching)
}
