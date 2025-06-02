//
//  LocationManager.swift
//  AccidentMap
//
//  Created by 문재윤 on 6/1/25.
//

import Foundation
import CoreLocation
import Combine


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    // 최신 위치 정보를 CLLocation 객체 형태로 저장합니다.
    @Published var currentLocation: CLLocation?
    // 위치 정보 요청 실패 시 에러 메시지를 저장합니다.
    @Published var errorMessage: String?

    override init() {
        super.init()
        // CLLocationManager의 delegate를 self로 설정하여 위치 업데이트 이벤트를 받습니다.
        locationManager.delegate = self
        // 원하는 위치 정확도를 설정합니다. 여기서는 가장 높은 정확도를 사용합니다.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 지정된 거리(미터 단위)를 이동해야만 위치 업데이트 이벤트를 발생시키도록 설정합니다.
        // 불필요한 업데이트를 줄여 배터리 소모를 줄일 수 있습니다.
        locationManager.distanceFilter = 50 // 50m 이동 시 업데이트
        
        // 앱 사용 중에 위치 서비스 접근 권한을 요청합니다.
        locationManager.requestWhenInUseAuthorization()
        
        // 위치 업데이트를 시작합니다.
        locationManager.startUpdatingLocation()
    }

    // 위치 정보가 업데이트될 때 호출되는 delegate 메서드입니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations 배열의 마지막(가장 최근) 위치 정보를 가져옵니다.
        guard let latestLocation = locations.last else { return }
        
        // UI 업데이트는 메인 스레드에서 이루어져야 하므로 DispatchQueue.main.async를 사용합니다.
        DispatchQueue.main.async {
            self.currentLocation = latestLocation
            // 위치 업데이트가 성공했으므로 에러 메시지는 nil로 초기화합니다.
            self.errorMessage = nil
        }
    }

    // 위치 정보 요청에 실패했을 때 호출되는 delegate 메서드입니다.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // UI 업데이트는 메인 스레드에서 이루어져야 하므로 DispatchQueue.main.async를 사용합니다.
        DispatchQueue.main.async {
            self.errorMessage = "위치 정보를 가져오는데 실패했습니다: \(error.localizedDescription)"
            // 에러 발생 시 현재 위치 정보는 유효하지 않을 수 있으므로 nil로 설정합니다.
            self.currentLocation = nil
        }
        // 에러 발생 시 위치 업데이트를 중지할 수도 있습니다. 필요에 따라 주석 해제하세요.
        // locationManager.stopUpdatingLocation()
    }
    
    // 위치 서비스 권한 상태가 변경될 때 호출되는 delegate 메서드입니다.
    // 이 메서드를 구현하여 앱이 위치 서비스를 사용 가능한 상태인지 확인할 수 있습니다.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // 권한이 허용된 상태이면 위치 업데이트를 시작합니다.
            manager.startUpdatingLocation()
            errorMessage = nil // 권한이 허용되면 에러 메시지를 지웁니다.
        case .denied, .restricted:
            // 권한이 거부되거나 제한된 경우 에러 메시지를 설정합니다.
            errorMessage = "위치 서비스 권한이 필요합니다. 설정에서 허용해주세요."
            manager.stopUpdatingLocation() // 위치 업데이트 중지
            currentLocation = nil // 위치 정보 초기화
        case .notDetermined:
            // 아직 권한이 요청되지 않은 상태입니다.
            errorMessage = "위치 서비스 권한 요청 대기 중..."
        @unknown default:
            // 알려지지 않은 새로운 권한 상태
            errorMessage = "알 수 없는 위치 권한 상태입니다."
        }
    }
}
