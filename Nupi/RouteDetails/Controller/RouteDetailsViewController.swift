//
//  RouteDetailsViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = routeDetailsView
        setupDelegate()
    }
    
    private lazy var routeDetailsView: RouteDetailsView = {
        let view = RouteDetailsView()
        return view
    }()
    
    // MARK: - function
    private func setupDelegate() {
        routeDetailsView.routeImageCollectionView.dataSource = self
    }
}

extension RouteDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        RouteDetailsModel.dummny().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RouteImageCollectionViewCell.identifier,
            for: indexPath
        ) as? RouteImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = RouteDetailsModel.dummny()
        cell.routeImageView.image = list[indexPath.row].image
        cell.countLabel.text = "\(indexPath.row + 1)/\(list.count)"
        return cell
    }
}
