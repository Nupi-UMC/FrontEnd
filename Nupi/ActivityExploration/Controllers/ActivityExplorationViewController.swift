//
//  ActivityExplorationViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

class ActivityExplorationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = activityExplorationView
        setupDelegate()
    }
    
    private lazy var activityExplorationView: ActivityExplorationView = {
        let view = ActivityExplorationView()
        view.backgroundColor = .white
        return view
    }()
    
    private func setupDelegate() {
        activityExplorationView.bannerCollectionView.dataSource = self
    }
}

extension ActivityExplorationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BannerModel.dummny().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCollectionViewCell.identifier,
            for: indexPath
        ) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = BannerModel.dummny()
        cell.bannerImageView.image = list[indexPath.row].image
        
        return cell
    }
}
