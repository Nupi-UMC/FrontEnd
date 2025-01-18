//
//  ViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let rootView = HomeView()
    let bannerData = BannerModel.dummy()
    let whatToplayData = WhatToPlayModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
                
        setupDataSource()
    }
    
    // MARK: - function
    private func setupDataSource(){
        rootView.bannerCollectionView.dataSource = self
        //rootView.bannerCollectionView.delegate = self
        rootView.whatToPlayCollectionView.dataSource = self
        //rootView.whatToPlayCollectionView.delegate = self
        rootView.whereToPlayCollectionView.dataSource = self
        rootView.ourMemoriesCollectionView.dataSource = self
    }
    
    // MARK: - action
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rootView.bannerCollectionView {
            return BannerModel.dummy().count
        } else if collectionView == rootView.whatToPlayCollectionView {
            return WhatToPlayModel.dummy().count
        } else if collectionView == rootView.ourMemoriesCollectionView {
            return OurMemoriesModel.dummy().count
        } else if collectionView == rootView.whereToPlayCollectionView {
            return WhereToPlayModel.dummy().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = BannerModel.dummy()
            cell.imageView.image = list[indexPath.row].image
            cell.titleLabel1.text = list[indexPath.row].title1
            cell.titleLabel2.text = list[indexPath.row].title2
            return cell
        }else if collectionView == rootView.whatToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhatToPlayCollectionViewCell.identifier, for: indexPath) as? WhatToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhatToPlayModel.dummy()
            cell.placeButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.placeLabel.text = list[indexPath.row].place
            return cell
        }else if collectionView == rootView.whereToPlayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhereToPlayCollectionViewCell.identifier, for: indexPath) as? WhereToPlayCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = WhereToPlayModel.dummy()
            cell.whereToPlayButton.setImage(UIImage(named:list[indexPath.row].image), for: .normal)
            cell.whereToPlayLabel.text = list[indexPath.row].place
            return cell
        }else if collectionView == rootView.ourMemoriesCollectionView {
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
