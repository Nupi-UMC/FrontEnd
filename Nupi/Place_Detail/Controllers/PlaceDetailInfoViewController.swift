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
    private var mapViewController: PlaceMapViewController!

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placeDetailInfoView
        //addMapView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInstagram))
        placeDetailInfoView.instagramLabel.isUserInteractionEnabled = true
        placeDetailInfoView.instagramLabel.addGestureRecognizer(tapGesture)
    }
    
    private lazy var placeDetailInfoView: PlaceDetailInfoView = {
        let view = PlaceDetailInfoView()
        return view
    }()

    // placeDetailInfoViewController일때 updateUI 함수
    func updateDetailInfoView(with placeDetail: PlaceDetailResult) {
        DispatchQueue.main.async {
            self.placeDetailInfoView.locationLabel.text = placeDetail.address
            self.placeDetailInfoView.timeLabel.text = placeDetail.businessHours
            self.placeDetailInfoView.phoneLabel.text = placeDetail.number
            if let attributedInstagramID = self.extractInstagramID(from: placeDetail.snsUrl) {
                self.placeDetailInfoView.instagramLabel.attributedText = attributedInstagramID
            } else {
                self.placeDetailInfoView.instagramLabel.text = nil
            }
                    
            self.instagramUrl = placeDetail.snsUrl
            
            // 📌 하단 지도 위치 업데이트
            //self.mapViewController.latitude = placeDetail.latitude ?? 37.5665
            //self.mapViewController.longitude = placeDetail.longitude ?? 126.9784
        }
    }

    // 인스타 아이디 추출 함수
    func extractInstagramID(from url: String) -> NSAttributedString? {
        let pattern = "https://www\\.instagram\\.com/([a-zA-Z0-9_.]+)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        if let match = regex?.firstMatch(in: url, options: [], range: NSRange(location: 0, length: url.utf16.count)) {
            if let range = Range(match.range(at: 1), in: url) {
                let username = "@\(url[range])" // 앞에 @ 추가
                
                // 🔹 언더라인 스타일 적용
                let attributes: [NSAttributedString.Key: Any] = [
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                return NSAttributedString(string: username, attributes: attributes)
            }
        }
        return nil
    }

    // 인스타 아이디 클릭하면 url로 이동하는 함수
    @objc private func openInstagram() {
        guard let urlString = instagramUrl, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    
    // 🔹 지도 뷰 추가
    private func addMapView() {
        mapViewController = PlaceMapViewController()
        mapViewController.view.frame = placeDetailInfoView.mapImageViewContainer.bounds
        placeDetailInfoView.mapImageViewContainer.addSubview(mapViewController.view)
        self.addChild(mapViewController)
        mapViewController.didMove(toParent: self)
    }
}
