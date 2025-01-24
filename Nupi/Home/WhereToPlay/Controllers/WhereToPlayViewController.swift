//
//  WhereToPlayViewController.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

class WhereToPlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = whereToPlayView
        
        setupDataSource()
    }
    private lazy var whereToPlayView: WhereToPlayView = {
        let view = WhereToPlayView()
        return view
    }()
    
    private func setupDataSource(){
        whereToPlayView.placeCollectionView.dataSource = self
        whereToPlayView.placeSortedCollectionView.dataSource = self
    }
}

extension WhereToPlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == whereToPlayView.placeCollectionView{
            return HongdaeModel.dummy().count
        } else if collectionView == whereToPlayView.placeSortedCollectionView{
            return HongdaeSortedModel.dummy().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == whereToPlayView.placeCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HongdaeCollectionViewCell.identifier, for: indexPath) as? HongdaeCollectionViewCell else {
                return UICollectionViewCell()
            }
            let list = HongdaeModel.dummy()
            cell.placeImageView.image = list[indexPath.row].image
            cell.tagLabel.text = list[indexPath.row].tag
            cell.placeLabel.text = list[indexPath.row].place
            cell.stationLabel.text = list[indexPath.row].station
            cell.descriptionLabel.text = list[indexPath.row].description
            return cell
        } else if collectionView == whereToPlayView.placeSortedCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HongdaeSortedCollectionViewCell.identifier, for: indexPath) as? HongdaeSortedCollectionViewCell else {
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

