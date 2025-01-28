//
//  ReviewsViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceReviewsViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlaceReviewsModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceReviewsCollectionViewCell.identifier, for: indexPath)
                as? PlaceReviewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let list = PlaceReviewsModel.dummy()
        cell.profileImage.image = list[indexPath.row].profileImage
        cell.nicknameLabel.text = list[indexPath.row].nicknameLabel
        cell.reviewLabel.text = list[indexPath.row].reviewLabel
        cell.dateLabel.text = list[indexPath.row].dateLabel

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placeReviewsView
        
        setupDelegate()
    }
    
    private lazy var placeReviewsView: PlaceReviewsView = {
        let view = PlaceReviewsView()
        return view
    }()

    private func setupDelegate(){
        placeReviewsView.placeReviewsCollectionView.dataSource = self
    }
}
