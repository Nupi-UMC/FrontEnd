//
//  PlaceMapViewController.swift
//  Nupi
//
//  Created by Dana Lim on 2/1/25.
//

import UIKit
import KakaoMapsSDK

class PlaceMapViewController : UIViewController {
    var mapViewContainer: KMViewContainer!
    var mapController: KMController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }
    /// Kakao Maps 지도 초기화
        private func setupMapView() {
            // KMViewContainer 생성 및 설정
            mapViewContainer = KMViewContainer(frame: view.bounds)
            mapViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(mapViewContainer)

            // KMController 생성 및 초기화
            mapController = KMController(viewContainer: mapViewContainer)
            mapController?.prepareEngine() // 엔진 준비
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
    
}
