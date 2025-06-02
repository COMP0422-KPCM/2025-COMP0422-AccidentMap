//
//  SearchCompleterViewModel.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/1/25.
//


import Foundation
import MapKit
import Combine

class SearchCompleterViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKLocalSearchCompletion] = []
    private var completer: MKLocalSearchCompleter

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
    }

    func updateSearchQuery(_ query: String) {
        completer.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("검색 자동완성 실패: \(error.localizedDescription)")
    }
}