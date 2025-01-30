//
//  PlaceDetailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit
import Alamofire

class PlaceDetailViewController: UIViewController {
    private var placeDetail: PlaceDetailResult? // 장소 상세 정보 저장

    private lazy var placeDetailView: PlaceDetailView = {
        let view = PlaceDetailView()
        return view
    }()
    
    private var storeId : Int?
    
    // Child View Controllers
    private let detailVC = PlaceDetailInfoViewController()
    private let photosVC = PlacePhotosViewController()
    private let routesVC = IncludedRoutesViewController()
    private let reviewsVC = PlaceReviewsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = placeDetailView

        placeDetailView.headerView.setUpImageSlider()
        
        setupSegmentedControl()
        showChildViewController(detailVC) // 초기 화면 설정
        
    }
    
    private func setupSegmentedControl() {
        let segmentedControl = placeDetailView.getSegmentedControl()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Remove current child view controller
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        // Add selected child view controller
        switch sender.selectedSegmentIndex {
        case 0:
            showChildViewController(detailVC)
        case 1:
            showChildViewController(photosVC)
        case 2:
            showChildViewController(routesVC)
        case 3:
            showChildViewController(reviewsVC)
        default:
            break
        }
        updateSegmentedControlLinePosition(sender)
    }
    
    private func updateSegmentedControlLinePosition(_ segmentedControl: UISegmentedControl) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = CGFloat(segmentedControl.selectedSegmentIndex) * segmentWidth + 16
        
        UIView.animate(withDuration: 0.3) {
            self.placeDetailView.segmentedControlLineView.snp.updateConstraints { make in
                make.leading.equalTo(segmentedControl.snp.leading).offset(leadingDistance)
            }
            self.placeDetailView.layoutIfNeeded()
        }
    }
    
    private func showChildViewController(_ childVC: UIViewController) {
        addChild(childVC)
        placeDetailView.containerView.addSubview(childVC.view)
        childVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        childVC.didMove(toParent: self)
    }
}

extension PlaceDetailViewController {
    func fetchPlaceDetail(storeId: Int) {
        self.storeId = 10 // `storeId` 저장
        let endpoint = "/api/place/\(storeId)" // API 엔드포인트
        
        APIClient.getRequest(endpoint: endpoint, token: nil) { (result: Result<PlaceDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                print("장소 상세 조회 성공:", response)
                guard let placeDetail = response.result else {
                                    print("장소 상세 정보가 없습니다.")
                                    return
                                }
                DispatchQueue.main.async {
                    self.updateUI(with: placeDetail) // UI 업데이트
                }
                
            case .failure(let error):
                print("장소 상세 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    /// 장소 상세 정보를 UI에 반영하는 메서드 추가
        private func updateUI(with placeDetail: PlaceDetailResult) {
            /*placeDetailView.headerView.setImage(from: placeDetail.image) // 헤더 이미지 설정
            placeDetailView.titleLabel.text = placeDetail.name
            placeDetailView.locationLabel.text = placeDetail.location
            placeDetailView.addressLabel.text = placeDetail.address
            placeDetailView.businessHoursLabel.text = "영업시간: \(placeDetail.businessHours)"
            placeDetailView.likeCountLabel.text = "\(placeDetail.likeNum)"
            placeDetailView.bookmarkCountLabel.text = " \(placeDetail.bookmarkNum)"*/
        }
}
extension PlaceDetailViewController {
    
    /// 좋아요 요청 (API 호출)
    private func toggleLike() {
        guard let storeId = placeDetail?.storeId else { return } // storeId 가져오기
        let memberId = 123 //현재 로그인된 사용자 ID (예제)
        
        let endpoint = "/api/store/\(storeId)/like/\(memberId)" //API 엔드포인트
        
        APIClient.postRequestWithoutParameters(endpoint: endpoint) { [weak self] (result: Result<PlaceLikeResponse, AFError>) in
            switch result {
            case .success(let response):
                print("좋아요 요청 성공:", response)
                
                DispatchQueue.main.async {
                    self?.updateLikeUI(saved: response.result!.saved)
                }
            case .failure(let error):
                print("좋아요 요청 실패:", error.localizedDescription)
            }
        }
    }
    
    /// 좋아요 상태 UI 업데이트
    private func updateLikeUI(saved: Bool) {
        let imageName = saved ? "liked_button" : "like_button"
        placeDetailView.headerView.likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    /// 북마크 요청 (API 호출)
    private func toggleBookmark() {
        guard let storeId = placeDetail?.storeId else { return } // storeId 가져오기
        let memberId = 123 //현재 로그인된 사용자 ID (예제)
        
        let endpoint = "/api/store/\(storeId)/bookmark/\(memberId)" //API 엔드포인트
        
        APIClient.postRequestWithoutParameters(endpoint: endpoint) { [weak self] (result: Result<PlaceBookmarkResponse, AFError>) in
            switch result {
            case .success(let response):
                print("좋아요 요청 성공:", response)
                
                DispatchQueue.main.async {
                    self?.updateBookmarkUI(saved: response.result!.saved)
                }
            case .failure(let error):
                print("좋아요 요청 실패:", error.localizedDescription)
            }
        }
    }
    
    /// 북마크 상태 UI 업데이트
    private func updateBookmarkUI(saved: Bool) {
        let imageName = saved ? "liked_button" : "like_button"
        placeDetailView.headerView.saveButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
