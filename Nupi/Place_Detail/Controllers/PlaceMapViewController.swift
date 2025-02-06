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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mapController?.activateEngine()
            print("✅ Kakao Maps 엔진 활성화 완료")
            self.addMapView()
        }
    }
    /// Kakao Maps 지도 초기화
    private func setupMapView() {
        mapViewContainer = KMViewContainer(frame: view.bounds)
        mapViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapViewContainer)
        
        mapController = KMController(viewContainer: mapViewContainer)
        mapController?.prepareEngine() // ✅ 엔진 준비
        print("✅ Kakao Maps 엔진 준비 완료")
    }
    
    /// 지도 추가
    private func addMapView() {
        let defaultPosition = MapPoint(longitude: 126.9784, latitude: 37.5665) // 시청역 디폴트 중심 좌표
        let mapviewInfo = MapviewInfo(viewName: "simpleMap", viewInfoName: "map", defaultPosition: defaultPosition)
        
        guard let controller = mapController else {
            print("❌ mapController가 nil입니다!")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            controller.addView(mapviewInfo)
            print("✅ addView() 호출됨: \(defaultPosition)")
        }
    }
}

