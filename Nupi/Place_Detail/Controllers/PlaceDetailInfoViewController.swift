//
//  DetailInfoViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit
import KakaoMapsSDK

class PlaceDetailInfoViewController: UIViewController {
    
    
    private var instagramUrl: String?
    private var mapController: KMController?
    private var mapContainer : KMViewContainer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placeDetailInfoView
        //setupMapView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInstagram))
        placeDetailInfoView.instagramLabel.isUserInteractionEnabled = true
        placeDetailInfoView.instagramLabel.addGestureRecognizer(tapGesture)
    }
    
    private lazy var placeDetailInfoView: PlaceDetailInfoView = {
        let view = PlaceDetailInfoView()
        return view
    }()


    //placeDetailInfoViewController일때 updateUI 함수
    func updateDetailInfoView(with placeDetail: PlaceDetailResult) {
        DispatchQueue.main.async {
            self.placeDetailInfoView.locationLabel.text = placeDetail.address
            self.placeDetailInfoView.timeLabel.text = placeDetail.businessHours
            self.placeDetailInfoView.phoneLabel.text = placeDetail.number
            let instagramID = self.extractInstagramID(from: placeDetail.snsUrl)
            self.placeDetailInfoView.instagramLabel.text = instagramID
            self.instagramUrl = placeDetail.snsUrl
            
            let latitude = placeDetail.latitude ?? 37.5665
            let longitude = placeDetail.longitude ?? 126.9784
            self.setMapLocation(latitude: latitude, longitude: longitude)
        }
    }
    //인스타아이디 추출 함수
    func extractInstagramID(from url: String) -> String? {
        let pattern = "https://www\\.instagram\\.com/([^/#?]+)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])

        if let match = regex?.firstMatch(in: url, options: [], range: NSRange(location: 0, length: url.utf16.count)) {
            if let range = Range(match.range(at: 1), in: url) {
                return String(url[range])
            }
        }
        return nil
    }
    //인스타 아이디 클릭하면 url로 이동하는 함수
    @objc private func openInstagram(){
        guard let urlString = instagramUrl, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)

    }
    
    /// 지도 위치 설정 함수 (안정성 개선)
        private func setMapLocation(latitude: Double, longitude: Double) {
            guard let controller = mapController else {
                print("❌ mapController가 nil입니다!")
                return
            }
            
            let newPosition = MapPoint(longitude: longitude, latitude: latitude)
            let mapviewInfo = MapviewInfo(viewName: "simpleMap", viewInfoName: "map", defaultPosition: newPosition)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                controller.addView(mapviewInfo)
                print("✅ 지도 중심이 \(latitude), \(longitude)로 설정됨")
            }
        }

    // Kakao 지도 초기화 함수 (안전한 `mapContainer` 설정)
        private func setupMapView() {
            
            mapContainer = placeDetailInfoView.mapImageViewContainer
            mapController = KMController(viewContainer: mapContainer!)

            print("✅ Kakao Maps 엔진 준비 중...")
            mapController?.prepareEngine()

            // ✅ 엔진 활성화 (지연 실행)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.mapController?.activateEngine()
                print("✅ Kakao Maps 엔진 활성화 완료")
            }
        }
}
