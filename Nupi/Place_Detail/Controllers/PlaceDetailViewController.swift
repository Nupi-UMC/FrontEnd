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
        
        // Keychain에 임시 토큰 직접 저장 (테스트용)
            let dummyAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJEYW5hbGltMDgxOUBuYXZlci5jb20iLCJtZW1iZXJJZCI6MTcsImlhdCI6MTczODk5MjgwOCwiZXhwIjoxNzQwMjAyNDA4fQ.bhFhpI4JjL-QFgrHruCxiC7IdPflvC0Lo26Fci0xVGE"  // 임시 Access Token
            let dummyRefreshToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJEYW5hbGltMDgxOUBuYXZlci5jb20iLCJpYXQiOjE3Mzg5OTI4MDgsImV4cCI6MTczOTAwMDAwOH0.Hz4Qg0mhAlx8_wdy7fhz6xkVYA92w2r3iLwAEdWSglI" // 임시 Refresh Token

            KeychainService.save(value: dummyAccessToken, for: "accessToken")
            KeychainService.save(value: dummyRefreshToken, for: "refreshToken")
        //
        super.viewDidLoad()
        self.view = placeDetailView
        placeDetailView.headerView.imageCollectionView.register(HeaderImageCollectionCell.self, forCellWithReuseIdentifier: HeaderImageCollectionCell.identifier)

        placeDetailView.headerView.setUpImageSlider(with: placeDetail?.slideImages ?? [])
        
        setupSegmentedControl()
        showChildViewController(detailVC) // 초기 화면 설정
        fetchPlaceDetail(storeId: 50)
        
        //버튼 클릭했을때
            placeDetailView.headerView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            placeDetailView.headerView.saveButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
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
            routesVC.setStoreId(storeId!)
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

        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }

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
            
            self.updateLikeUI(saved: placeDetail.isLiked, likeNum: placeDetail.likeNum)
            self.updateBookmarkUI(saved: placeDetail.isBookmarked, bookmarkNum: placeDetail.bookmarkNum)
            
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
    
    // 좋아요 요청 (API 호출)
    private func toggleLike(previousState: Bool, previousCount: Int) {
        guard let storeId = placeDetail?.id else { return }

        let endpoint = "/api/stores/\(storeId)/like"

        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }

        APIClient.postRequestWithoutParameters(endpoint: endpoint, token: token) { [weak self] (result: Result<PlaceLikeResponse, AFError>) in
            switch result {
            case .success(let response):
                print("좋아요 요청 성공:", response)
            case .failure(let error):
                print("좋아요 요청 실패:", error.localizedDescription)
                DispatchQueue.main.async {
                    self?.restoreLikeState(previousState: previousState, previousCount: previousCount)  // 요청 실패 시 복구
                }
            }
        }
    }
    
    ////좋아요 버튼 UI 즉시 변경
    private func updateLikeUI(saved: Bool, likeNum: Int) {
        let imageName = saved ? "selectedLike" : "like_button"
        placeDetailView.headerView.likeButton.setImage(UIImage(named: imageName), for: .normal)
        placeDetailView.headerView.likeLabel.text = "\(likeNum)"
    }

    
    /// 북마크 요청 (API 호출)
    private func toggleBookmark(previousState: Bool, previousCount: Int) {
        guard let storeId = placeDetail?.id else { return }

        let endpoint = "/api/stores/\(storeId)/bookmark"

        guard let token = KeychainService.load(for: "accessToken") else {
            print("Access Token 없음. 로그인이 필요합니다.")
            return
        }

        APIClient.postRequestWithoutParameters(endpoint: endpoint, token: token) { [weak self] (result: Result<PlaceBookmarkResponse, AFError>) in
            switch result {
            case .success(let response):
                print("북마크 요청 성공:", response)
            case .failure(let error):
                print("북마크 요청 실패:", error.localizedDescription)
                DispatchQueue.main.async {
                    self?.restoreBookmarkState(previousState: previousState, previousCount: previousCount)  // 요청 실패 시 복구
                }
            }
        }
    }

    /// API 요청 실패 시 좋아요 상태 복구
    private func restoreLikeState(previousState: Bool, previousCount: Int) {
        let imageName = previousState ? "selectedLike" : "like_button"
        placeDetailView.headerView.likeButton.setImage(UIImage(named: imageName), for: .normal)
        placeDetailView.headerView.likeLabel.text = "\(previousCount)"
    }

    /// API 요청 실패 시 북마크 상태 복구
    private func restoreBookmarkState(previousState: Bool, previousCount: Int) {
        let imageName = previousState ? "selectedBookmark" : "save_button"
        placeDetailView.headerView.saveButton.setImage(UIImage(named: imageName), for: .normal)
        placeDetailView.headerView.saveLabel.text = "\(previousCount)"
    }
    
    /// 북마크 버튼 UI 즉시 변경
    private func updateBookmarkUI(saved: Bool, bookmarkNum: Int) {
        let imageName = saved ? "selectedBookmark" : "save_button"
        placeDetailView.headerView.saveButton.setImage(UIImage(named: imageName), for: .normal)
        placeDetailView.headerView.saveLabel.text = "\(bookmarkNum)"
    }

    /// 좋아요 버튼 클릭
    @objc private func likeButtonTapped() {
        let isCurrentlyLiked = placeDetailView.headerView.likeButton.image(for: .normal) == UIImage(named: "selectedLike")
        
        // 좋아요 UI 변경
        toggleLikeButtonUI()
        let updatedLikeNum = (isCurrentlyLiked ? -1 : 1) + (Int(placeDetailView.headerView.likeLabel.text ?? "0") ?? 0)
        placeDetailView.headerView.likeLabel.text = "\(updatedLikeNum)" // 좋아요 수 업데이트

        toggleLike(previousState: isCurrentlyLiked, previousCount: updatedLikeNum - (isCurrentlyLiked ? -1 : 1))
    }

    /// 북마크 버튼 클릭
    @objc private func bookmarkButtonTapped() {
        let isCurrentlyBookmarked = placeDetailView.headerView.saveButton.image(for: .normal) == UIImage(named: "selectedBookmark")
        
        // 북마크 UI 변경
        toggleBookmarkButtonUI()
        let updatedBookmarkNum = (isCurrentlyBookmarked ? -1 : 1) + (Int(placeDetailView.headerView.saveLabel.text ?? "0") ?? 0)
        placeDetailView.headerView.saveLabel.text = "\(updatedBookmarkNum)" // 북마크 수 업데이트

        toggleBookmark(previousState: isCurrentlyBookmarked, previousCount: updatedBookmarkNum - (isCurrentlyBookmarked ? -1 : 1))
    }

    /// 좋아요 버튼 UI 즉시 변경
    private func toggleLikeButtonUI() {
        let currentImage = placeDetailView.headerView.likeButton.image(for: .normal)
        let newImage = (currentImage == UIImage(named: "like_button")) ? UIImage(named: "selectedLike") : UIImage(named: "like_button")
        placeDetailView.headerView.likeButton.setImage(newImage, for: .normal)
    }

    /// 북마크 버튼 UI 즉시 변경
    private func toggleBookmarkButtonUI() {
        let currentImage = placeDetailView.headerView.saveButton.image(for: .normal)
        let newImage = (currentImage == UIImage(named: "save_button")) ? UIImage(named: "selectedBookmark") : UIImage(named: "save_button")
        placeDetailView.headerView.saveButton.setImage(newImage, for: .normal)
    }
}
