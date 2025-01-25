//
//  ViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    let bannerData = BannerModel.dummy()
    let whatToplayData = WhatToPlayModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        setupActions()
        setupDataSource()
    }
    
    // MARK: - function
    private func setupActions() {
        homeView.searchButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        homeView.myRouteButton.addTarget(self, action: #selector(myRouteButtonDidTap), for: .touchUpInside)
    }
    
    private func setupDataSource(){
        homeView.bannerCollectionView.dataSource = self
        //rootView.bannerCollectionView.delegate = self
        homeView.whatToPlayCollectionView.dataSource = self
        //rootView.whatToPlayCollectionView.delegate = self
        homeView.whereToPlayCollectionView.dataSource = self
        homeView.ourMemoriesCollectionView.dataSource = self
    }
    
    // MARK: - action
    @objc
    private func searchButtonDidTap() {
        let activityExplorationVC = ActivityExplorationViewController()
        self.navigationController?.pushViewController(activityExplorationVC, animated: true)
    }
    
    @objc
    private func myRouteButtonDidTap() {
        let myRouteVC = MyRouteViewController()
        self.navigationController?.pushViewController(myRouteVC, animated: true)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.bannerCollectionView {
            return BannerModel.dummy().count
        } else if collectionView == homeView.whatToPlayCollectionView {
            return WhatToPlayModel.dummy().count
        } else if collectionView == homeView.ourMemoriesCollectionView {
            return OurMemoriesModel.dummy().count
        } else if collectionView == homeView.whereToPlayCollectionView {
            return WhereToPlayModel.dummy().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = BannerModel.dummy()
            cell.imageView.image = list[indexPath.row].image
            cell.titleLabel1.text = list[indexPath.row].title1
            cell.titleLabel2.text = list[indexPath.row].title2
            return cell
        } else if collectionView == homeView.whatToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhatToPlayCollectionViewCell.identifier, for: indexPath) as? WhatToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhatToPlayModel.dummy()
            cell.placeButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.placeLabel.text = list[indexPath.row].place
            return cell
        } else if collectionView == homeView.whereToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhereToPlayCollectionViewCell.identifier, for: indexPath) as? WhereToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhereToPlayModel.dummy()
            cell.whereToPlayButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.whereToPlayLabel.text = list[indexPath.row].place
            return cell
        } else if collectionView == homeView.ourMemoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OurMemoriesCollectionViewCell.identifier, for: indexPath) as?
                    OurMemoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = OurMemoriesModel.dummy()
            cell.memoriesimageView.image = list[indexPath.row].image
            cell.dateLabel.text = list[indexPath.row].date
            return cell
        }
        return UICollectionViewCell()
    }
}
