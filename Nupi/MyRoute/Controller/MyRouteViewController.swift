//
//  MyRouteViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit

class MyRouteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myRouteView
        setupDelegate()
        setupAction()
    }
    
    private lazy var myRouteView: MyRouteView = {
        let view = MyRouteView()
        return view
    }()
    
    private func setupAction() {
        myRouteView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }
    
    private func setupDelegate() {
        myRouteView.routeCollectionView.dataSource = self
    }
    
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        myRouteView.updateUnderlinePosition(selectedIndex: segment.selectedSegmentIndex)
    }
    
}

extension MyRouteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RouteModel.dummny().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RouteCollectionViewCell.identifier,
            for: indexPath
        ) as? RouteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = RouteModel.dummny()
        cell.routeImageView.image = list[indexPath.row].routePic
        cell.routeNameLabel.text = list[indexPath.row].routeName
        cell.routePlaceLabel.text = list[indexPath.row].routePlace
        
        return cell
    }
}
