//
//  WhatToPlayViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/24/25.
//

import UIKit

class WhatToPlayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = whatToPlayView
        setupDataSource()
    }
    
    private lazy var whatToPlayView: WhatToPlayView = {
        let view = WhatToPlayView()
        return view
    }()
    
    private func setupDataSource(){
        whatToPlayView.placeCollectionView.dataSource = self
        whatToPlayView.hotPlaceCollectionView.dataSource = self
    }
}

extension WhatToPlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == whatToPlayView.placeCollectionView{
            return IzakayaModel.dummy().count
        } else if collectionView == whatToPlayView.hotPlaceCollectionView{
            return HotIzakayaModel.dummy().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == whatToPlayView.placeCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IzakayaCollectionViewCell.identifier, for: indexPath) as? IzakayaCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = IzakayaModel.dummy()
            cell.placeImageView.image = list[indexPath.row].image
            cell.tagLabel.text = list[indexPath.row].tag
            cell.placeLabel.text = list[indexPath.row].place
            cell.stationLabel.text = list[indexPath.row].station
            cell.descriptionLabel.text = list[indexPath.row].description
            return cell
        } else if collectionView == whatToPlayView.hotPlaceCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotIzakayaCollectionViewCell.identifier, for: indexPath) as? HotIzakayaCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = HotIzakayaModel.dummy()
            cell.placeImageView.image = list[indexPath.row].image
            cell.placeLabel.text = list[indexPath.row].place
            cell.stationLabel.text = list[indexPath.row].station
            return cell
        }
        return UICollectionViewCell()
    }
}
