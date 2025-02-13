//
//  RouteDetailsViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteDetailsViewController: UIViewController {
    
    var routeId: Int?
    private var stores: [RouteStoresModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = routeDetailsView
        setupDelegate()
        setupActions()
        
        if let routeId = routeId {
            print("Route ID: \(routeId)")
            fetchRouteDetails(routeId: routeId)
        }
    }
    
    private lazy var routeDetailsView: RouteDetailsView = {
        let view = RouteDetailsView()
        return view
    }()

    // MARK: - function
    private func setupActions() {
        routeDetailsView.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        routeDetailsView.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonDidTap), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        routeDetailsView.routeImageCollectionView.dataSource = self
        routeDetailsView.routePlacesCollectionView.dataSource = self
        routeDetailsView.routeReviewsCollectionView.dataSource = self
    }
    
    // 경로 상세 API 호출
    private func fetchRouteDetails(routeId: Int) {
        APIClient.fetchRouteDetails(routeId: routeId) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self?.stores = response.result.storeList.map {
                            RouteStoresModel(
                                storeId: $0.storeId,
                                storeName: $0.storeName,
                                image: $0.image
                            )
                        }
                        
                        self?.routeDetailsView.updateUI(
                            routeName: response.result.routeName,
                            location: response.result.location,
                            likeNum: response.result.likeNum,
                            bookmarkNum: response.result.bookmarkNum,
                            content: response.result.content,
                            isLiked: response.result.isLiked,
                            isBookmarked: response.result.isBookmarked
                        )
                        self?.routeDetailsView.routePlacesCollectionView.reloadData()
                    }
                } else {
                    print("API 실패: \(response.message)")
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - action
    @objc
    private func likeButtonDidTap() {
        guard let routeId = routeId else { return }
        routeDetailsView.likeButton.isSelected.toggle()
        
        APIClient.updateLikeStatus(routeId: routeId) { [weak self] success in
            guard let self = self else { return }
            
            if !success {
                self.routeDetailsView.likeButton.isSelected.toggle()
            }
        }
    }
    
    @objc private func bookmarkButtonDidTap() {
        guard let routeId = routeId else { return }
        routeDetailsView.bookmarkButton.isSelected.toggle()

        APIClient.updateBookmarkStatus(routeId: routeId) { [weak self] success in
            guard let self = self else { return }
            
            if !success {
                self.routeDetailsView.bookmarkButton.isSelected.toggle()
            }
        }
    }
}

extension RouteDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == routeDetailsView.routeImageCollectionView {
            return RouteImageModel.dummny().count
        } else if collectionView == routeDetailsView.routePlacesCollectionView {
            return stores.count
        } else if collectionView == routeDetailsView.routeReviewsCollectionView {
            return RouteReviewModel.dummny().count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == routeDetailsView.routeImageCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RouteImageCollectionViewCell.identifier,
                for: indexPath
            ) as? RouteImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let list = RouteImageModel.dummny()
            cell.routeImageView.image = list[indexPath.row].image
            cell.countLabel.text = "\(indexPath.row + 1)/\(list.count)"
            return cell
        } else if collectionView == routeDetailsView.routePlacesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoutePlaceCollectionViewCell.identifier,
                for: indexPath
            ) as? RoutePlaceCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let store = stores[indexPath.row]
            
            if let image = store.image, let url = URL(string: image) {
                cell.placeImageView.kf.setImage(with: url)
            } else {
                cell.placeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
            }
            
            cell.placeNameLabel.text = store.storeName
            
            return cell
        } else if collectionView == routeDetailsView.routeReviewsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RouteReivewCollectionViewCell.identifier,
                for: indexPath
            ) as? RouteReivewCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let list = RouteReviewModel.dummny()
            cell.profileImageView.image = list[indexPath.row].image
            cell.nicknameLabel.text = list[indexPath.row].nickname
            cell.reviewContentLabel.text = list[indexPath.row].content
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
