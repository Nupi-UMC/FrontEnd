//
//  PlaceMapViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import KakaoMapsSDK

class PlaceMapViewController: UIViewController {
    private var mapViewContainer: KMViewContainer!
    private var mapController: KMController?
    
    var latitude: Double = 37.5665 // 기본값: 서울 시청
    var longitude: Double = 126.9784

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.mapController?.getView("detailMapView") != nil {
                print("🔹 Kakao Maps 엔진이 이미 활성화됨")
                return
            }
            self.activateEngineAndAddMap()
        }
    }

    /// ✅ Kakao Maps 지도 초기화 (한 번만 실행)
    private func setupMapView() {
        guard mapController == nil else { return } // 🔹 중복 실행 방지

        mapViewContainer = KMViewContainer(frame: view.bounds)
        mapViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapViewContainer)

        mapController = KMController(viewContainer: mapViewContainer)
        mapController?.prepareEngine()

        print("✅ Kakao Maps 엔진 준비 완료")
    }

    /// ✅ Kakao Maps 엔진 활성화 + 지도 추가
    private func activateEngineAndAddMap() {
        guard let controller = mapController else {
            print("❌ mapController가 nil입니다!")
            return
        }

        controller.activateEngine()
        print("✅ Kakao Maps 엔진 활성화 완료")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.addMapView()
        }
    }

    /// ✅ 지도 추가 (마커 없음)
    private func addMapView() {
        let mapPosition = MapPoint(longitude: longitude, latitude: latitude)
        let mapviewInfo = MapviewInfo(viewName: "detailMapView", viewInfoName: "map", defaultPosition: mapPosition)

        guard let controller = mapController else {
            print("❌ mapController가 nil입니다!")
            return
        }

        controller.addView(mapviewInfo)
        print("🟢 지도 추가 완료 - 위도: \(latitude), 경도: \(longitude)")
    }
}
