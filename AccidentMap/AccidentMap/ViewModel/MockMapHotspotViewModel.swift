//
//  MockMapHotspotViewModel.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/24/25.
//
import SwiftUI

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
