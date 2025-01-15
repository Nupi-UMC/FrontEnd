//
//  ViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let rootView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
                
        setupDelegate()
    }
    
    private func setupDelegate(){
        rootView.bannerCollectionView.dataSource = self
        //rootView.bannerCollectionView.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BannerModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = BannerModel.dummy()
        
        cell.imageView.image = list[indexPath.row].image
        cell.titleLabel1.text = list[indexPath.row].title1
        cell.titleLabel2.text = list[indexPath.row].title2
        
        return cell
    }
}
