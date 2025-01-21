//
//  ActivityExplorationViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

class ActivityExplorationViewController: UIViewController {
    
    // 카테고리 배열
    let categories = ["전시", "소품샵", "굿즈샵", "맛집", "카페", "테마카페", "팝업", "전시", "클래스"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = activityExplorationView
        setupDelegate()
    }
    
    private lazy var activityExplorationView: ActivityExplorationView = {
        let view = ActivityExplorationView()
        view.backgroundColor = .bg
        return view
    }()
    
    private func setupDelegate() {
        activityExplorationView.bannerCollectionView.dataSource = self
        activityExplorationView.categoryCollectionView.dataSource = self
        activityExplorationView.categoryCollectionView.delegate = self
    }
}

extension ActivityExplorationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == activityExplorationView.bannerCollectionView {
            return BannerModel.dummny().count
        } else if collectionView == activityExplorationView.categoryCollectionView {
            return categories.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == activityExplorationView.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.identifier,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let list = BannerModel.dummny()
            cell.bannerImageView.image = list[indexPath.row].image
            return cell
        } else if collectionView == activityExplorationView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.categoryButton.setTitle(categories[indexPath.row], for: .normal)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ActivityExplorationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let text = categories[indexPath.item]
        let tmpLabel = UILabel()
        tmpLabel.text = text
        tmpLabel.font = UIFont(name: "WantedSans-Medium", size: 16)
        tmpLabel.sizeToFit()

        let width = tmpLabel.intrinsicContentSize.width
        let height: CGFloat = 29
        
        return CGSize(width: width + 24, height: height)
    }
}
