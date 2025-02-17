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
    var poiManager: PoiManager?
    private var nearbyVC: NearbyListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        addOverlayViewController()
        setupNearbyPreview()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called") // 확인용 로그

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.mapController?.activateEngine() // ✅ 지도 엔진 활성화
                print("Engine activated") // 활성화 여부 확인

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 추가 딜레이
                    if let mapView = self.mapController?.getView("nupiMap") as? KakaoMap {
                        print("✅ MapView retrieved successfully") // 지도 뷰 확인
                        self.poiManager = PoiManager(mapView: mapView)
                        self.poiManager?.createLabelLayer()

                        // 카메라 이동 및 POI 추가
                        self.moveCamera()
                        self.fetchAndDisplayTestPOIs()
                    } else {
                        print("❌ MapView retrieval failed")
                    }
                }
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
        
        addMapView()
    }
    

    /// 지도 추가
    private func addMapView() {
        let defaultPosition = MapPoint(longitude: 127.05582, latitude: 37.544564) // 성수역 디폴트 중심 좌표
        let mapviewInfo = MapviewInfo(viewName: "nupiMap", viewInfoName: "map", defaultPosition: defaultPosition)

        if let controller = mapController {
            controller.addView(mapviewInfo)
        } else {
            print("❌ mapController가 nil입니다!")
        }
    }

    /// 카메라 이동
    private func moveCamera() {
        guard let mapView = mapController?.getView("nupiMap") as? KakaoMap else {
            return
        }
        
        // 카메라 업데이트 생성
        let cameraUpdate = CameraUpdate.make(
            target: MapPoint(longitude: 127.05582, latitude: 37.544564), // 목표 좌표 (성수역)
            zoomLevel: 15,
            rotation: 1.7,
            tilt: 0.0,
            mapView: mapView
        )
        
        // 카메라 이동
        mapView.moveCamera(cameraUpdate)
    }
    
    private func fetchAndDisplayPOIs() {
        print("Fetching POIs from API...")

        ApiManager.shared.fetchRouteStores { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let stores):
                print("✅ Fetched \(stores.count) POIs from API")
                
                // 지도에 POI 추가
                DispatchQueue.main.async {
                    self.poiManager?.createPois(with: stores)
                }
            case .failure(let error):
                print("❌ Failed to fetch POIs: \(error.localizedDescription)")
            }
        }
    }
    
    let testStores: [RouteStore] = [
        RouteStore(
            id: 57,
            slideImages: ["https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_172.jpg",
                          "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_170.jpg",
                          "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_171.jpg"],
            name: "사무엘스몰즈",
            category: "소품샵",
            groupInfo: "인테리어 소품",
            location: "성수역 3번 출구",
            likeNum: 0,
            bookmarkNum: 0,
            latitude: 37.5551,
            longitude: 126.9707
        ),
        RouteStore(
            id: 60,
            slideImages: [
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_173.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_174.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_175.jpg"],
            name: "어니언",
            category: "카페",
            groupInfo: "카페",
            location: "성수역 2번 출구",
            likeNum: 20,
            bookmarkNum: 15,
            latitude: 37.54476,
            longitude: 127.0582
        ),
        RouteStore(
            id: 69,
            slideImages: [
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_105.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_102.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_103.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_104.jpg"],
            name: "쎈느",
            category: "카페",
            groupInfo: "카페",
            location: "성수역 4번 출구",
            likeNum: 20,
            bookmarkNum: 15,
            latitude: 37.54478,
            longitude: 127.05342
        ),
        RouteStore(
            id: 51,
            slideImages: [
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_227.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_224.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_225.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_226.jpg"],
            name: "마를리",
            category: "카페",
            groupInfo: "케이크전문",
            location: "성수역 4번 출구",
            likeNum: 0,
            bookmarkNum: 0,
            latitude: 37.542816,
            longitude: 127.054794
        ),
        RouteStore(
            id: 59,
            slideImages: [
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_152.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_153.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_154.jpg",
                "https://nupibackend.s3.ap-northeast-2.amazonaws.com/image_155.jpg"],
            name: "소브티하우스",
            category: "소품샵",
            groupInfo: "인테리어 소품",
            location: "성수역 4번 출구",
            likeNum: 0,
            bookmarkNum: 0,
            latitude: 37.54325,
            longitude: 127.053566
        )
    ]
    

    
    private func fetchAndDisplayTestPOIs() {
       
        print("POI data prepared: \(testStores)")
        
        // POI를 지도에 추가
        poiManager?.createPois(with: testStores)
        
    }

    private func addOverlayViewController() {
        let overlayVC = RouteOverlayViewController()
        overlayVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(overlayVC)
        view.addSubview(overlayVC.view)
        overlayVC.didMove(toParent: self)

        NSLayoutConstraint.activate([
            overlayVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            overlayVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNearbyPreview() {
            let nearbyVC = NearbyListViewController()
            nearbyVC.routeStore = testStores // 테스트 데이터 전달

            addChild(nearbyVC)
            view.addSubview(nearbyVC.view)

            nearbyVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nearbyVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                nearbyVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                nearbyVC.view.heightAnchor.constraint(equalToConstant: 900),
                nearbyVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            nearbyVC.didMove(toParent: self)
            self.nearbyVC = nearbyVC

            // 터치 제스처 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expandNearbyPlaces))
            nearbyVC.view.addGestureRecognizer(tapGesture)
        }
    
    @objc private func expandNearbyPlaces() {
            guard let nearbyVC = nearbyVC else { return }

            UIView.animate(withDuration: 0.3, animations: {
                nearbyVC.view.frame = CGRect(x: 0, y: self.view.frame.height / 2, width: self.view.frame.width, height: self.view.frame.height / 2)
            })
        }
}
