//
//  IncludedRoutesViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class IncludedRoutesViewController: UIViewController, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return IncludedRoutesModel.dummy().count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncludedRoutesCollectionViewCell.identifier, for: indexPath)
                as? IncludedRoutesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let list = IncludedRoutesModel.dummy()
        //cell.profileImage.image = list[indexPath.row].profileImage
        cell.routeTitleLabel.text = list[indexPath.row].routeTitle
        cell.routeLocationLabel.text = list[indexPath.row].routeLocation
        cell.likeCountLabel.text = list[indexPath.row].likeCountLabel
        cell.saveCountLabel.text = list[indexPath.row].saveCountLabel

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = includedRoutesView
        
        setupDelegate()
    }
    
    private lazy var includedRoutesView: IncludedRoutesView = {
        let view = IncludedRoutesView()
        return view
    }()
    
    private func setupDelegate(){
        includedRoutesView.includedRoutesCollectionView.dataSource = self
    }

}
