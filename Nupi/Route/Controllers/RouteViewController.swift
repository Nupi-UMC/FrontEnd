//
//  RouteViewController.swift
//  Nupi
//
//  Created by narong on 1/21/25.
//

import UIKit
import KakaoMapsSDK

class RouteViewController: UIViewController {

    var mapViewContainer: KMViewContainer!
    var mapController: KMController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.mapController?.activateEngine() // ✅ 지도 엔진 활성화
            self.addMapView()
            self.moveCamera() // ✅ 카메라 이동
        }
    }

    /// Kakao Maps 지도 초기화
    private func setupMapView() {
        // KMViewContainer 생성 및 설정
        mapViewContainer = KMViewContainer(frame: view.bounds)
        mapViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapViewContainer)

        // KMController 생성 및 초기화
        mapController = KMController(viewContainer: mapViewContainer)
        mapController?.prepareEngine() // ✅ 엔진 준비
    }

    /// 지도 추가
    private func addMapView() {
        let defaultPosition = MapPoint(longitude: 126.9784, latitude: 37.5665) // 시청역 디폴트 중심 좌표
        let mapviewInfo = MapviewInfo(viewName: "simpleMap", viewInfoName: "map", defaultPosition: defaultPosition)

        if let controller = mapController {
            controller.addView(mapviewInfo)
            print("✅ addView() 호출됨: \(defaultPosition)")
        } else {
            print("❌ mapController가 nil입니다!")
        }
    }

    /// 카메라 이동
    private func moveCamera() {
        guard let mapView = mapController?.getView("simpleMap") as? KakaoMap else {
            return
        }

        // 카메라 업데이트 생성
        let cameraUpdate = CameraUpdate.make(
            target: MapPoint(longitude: 126.978862, latitude: 37.546086), // 목표 좌표
            zoomLevel: 15, // 줌 레벨
            rotation: 1.7, // 회전 각도
            tilt: 0.0, // 틸트 각도
            mapView: mapView
        )

        // 카메라 이동
        mapView.moveCamera(cameraUpdate)
    }
}
