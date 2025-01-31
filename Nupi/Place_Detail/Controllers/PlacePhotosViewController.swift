//
//  PhotosViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlacePhotosViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlacePhotosModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacePhotosCollectionViewCell.identifier, for: indexPath)
                as? PlacePhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        let list = PlacePhotosModel.dummy()
        cell.imageView.image = list[indexPath.row].image
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placePhotosView
        
        setupDelegate()
    }
    
    private lazy var placePhotosView: PlacePhotosView = {
        let view = PlacePhotosView()
        return view
    }()
    
    private func setupDelegate(){
        placePhotosView.placePhotosCollectionView.dataSource = self
    }
    
}
