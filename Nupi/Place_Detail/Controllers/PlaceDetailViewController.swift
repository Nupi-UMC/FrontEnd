//
//  PlaceDetailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit
import Alamofire

class PlaceDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderImageCollectionCell.identifier, for: indexPath) as? HeaderImageCollectionCell else {
                    return UICollectionViewCell()
                }
                let imageURL = imageURLs[indexPath.item]
                cell.configure(with: imageURL)
                return cell
    }
    
    private var placeDetail: PlaceDetailResult? // 장소 상세 정보 저장
    private var imageURLs: [String] = [] //이미지 URL 리스트 저장

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
        placeDetailView.headerView.imageCollectionView.register(HeaderImageCollectionCell.self, forCellWithReuseIdentifier: HeaderImageCollectionCell.identifier)

        placeDetailView.headerView.setUpImageSlider(with: placeDetail?.slideImages ?? [])
        
        setupSegmentedControl()
        showChildViewController(detailVC) // 초기 화면 설정
        fetchPlaceDetail(storeId: 50)
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
            photosVC.setStoreId(storeId!)
            showChildViewController(photosVC)
        case 2:
            showChildViewController(routesVC)
            routesVC.fetchRoutesContainingPlace(storeId: 50)
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
        
        UIView.animate(withDuration: 0.1) {
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
    //서버에서 장소 상세정보 불러오는 함수
    func fetchPlaceDetail(storeId: Int) {
            self.storeId = storeId

            let endpoint = "/api/stores/\(storeId)/detail"
            let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5hbGltMDgxOUBnbWFpbC5jb20iLCJtZW1iZXJJZCI6MTAsImlhdCI6MTczODczMzE0OCwiZXhwIjoxNzM5OTQyNzQ4fQ.71bgaA4HTzhcNQN4TOV0PgYdJ0TDH983UF-wtErATPM"

        APIClient.getRequest(endpoint: endpoint, token: token) { (result: Result<PlaceDetailResponse, AFError>) in
                switch result {
                case .success(let response):
                    print("장소 상세 조회 성공:", response)

                    guard let placeDetail = response.result else {
                        print("장소 상세 정보 없음")
                        return
                    }

                    DispatchQueue.main.async {
                        self.placeDetail = placeDetail
                        self.updateUI(with: placeDetail)
                    }

                case .failure(let error):
                    print("장소 상세 조회 실패: \(error.localizedDescription)")
                    if let statusCode = error.responseCode {
                        print("HTTP 상태 코드: \(statusCode)")
                    }
                }
            }
        }

    /// 장소 상세 정보를 UI에 반영하는 메서드
    private func updateUI(with placeDetail: PlaceDetailResult) {
        DispatchQueue.main.async {
            self.placeDetailView.headerView.titleLabel.text = placeDetail.name
            self.placeDetailView.headerView.locationLabel.text = placeDetail.location
            
            self.placeDetailView.headerView.likeLabel.text = "\(placeDetail.likeNum)"
            self.placeDetailView.headerView.saveLabel.text = "\(placeDetail.bookmarkNum)"
            self.updateLikeUI(saved: placeDetail.isLiked)
            self.updateBookmarkUI(saved: placeDetail.isBookmarked)
            
            // slideImages 업데이트
                    if let slideImages = placeDetail.slideImages {
                        self.imageURLs = slideImages
                        self.placeDetailView.headerView.setUpImageSlider(with: slideImages)
                    }
            
            //  선택된 뷰 컨트롤러가 `detailVC`인지 확인
            if let currentVC = self.children.first {
                switch currentVC {
                case let detailVC as PlaceDetailInfoViewController:
                    detailVC.updateDetailInfoView(with: placeDetail) // 장소 상세 정보 업데이트
                default:
                    print("")
                }
            }
        }
    }
}
extension PlaceDetailViewController {
    
    ///  좋아요 요청 (API 호출)
        private func toggleLike() {
            guard let storeId = placeDetail?.id else { return }

            let endpoint = "/api/stores/\(storeId)/like" // API 엔드포인트

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
        guard let storeId = placeDetail?.id else { return }

            let endpoint = "/api/stores/\(storeId)/bookmark"

            APIClient.postRequestWithoutParameters(endpoint: endpoint) { [weak self] (result: Result<PlaceBookmarkResponse, AFError>) in
                switch result {
                case .success(let response):
                    print("북마크 요청 성공:", response)
                    
                    DispatchQueue.main.async {
                        self?.updateBookmarkUI(saved: response.result!.saved)
                    }
                case .failure(let error):
                    print("북마크 요청 실패:", error.localizedDescription)
                }
            }
    }
    
    /// 북마크 상태 UI 업데이트
    private func updateBookmarkUI(saved: Bool) {
        let imageName = saved ? "liked_button" : "like_button"
        placeDetailView.headerView.saveButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
