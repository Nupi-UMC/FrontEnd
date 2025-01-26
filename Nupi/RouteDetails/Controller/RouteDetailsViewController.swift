//
//  RouteDetailsViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = routeDetailsView
        setupDelegate()
    }
    
    private lazy var routeDetailsView: RouteDetailsView = {
        let view = RouteDetailsView()
        return view
    }()
    
    // MARK: - function
    private func setupDelegate() {
        routeDetailsView.routeImageCollectionView.dataSource = self
        routeDetailsView.routePlacesCollectionView.dataSource = self
        routeDetailsView.routeReviewsCollectionView.dataSource = self
    }
}

extension RouteDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == routeDetailsView.routeImageCollectionView {
            return RouteDetailsModel.dummny().count
        } else if collectionView == routeDetailsView.routePlacesCollectionView {
            return RoutePlacesModel.dummny().count
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
            
            let list = RouteDetailsModel.dummny()
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
            
            let list = RoutePlacesModel.dummny()
            cell.placeImageView.image = list[indexPath.row].image
            cell.placeNameLabel.text = list[indexPath.row].title
            
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
