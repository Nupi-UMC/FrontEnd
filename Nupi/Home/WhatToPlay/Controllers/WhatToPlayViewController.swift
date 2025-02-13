//
//  WhatToPlayViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/24/25.
//

import UIKit
import Then

class WhatToPlayViewController: UIViewController {
    private var stores: [StoreModel] = [] // 장소 정보 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = whatToPlayView
        
        setupDataSource()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private lazy var whatToPlayView: WhatToPlayView = {
        let view = WhatToPlayView()
        return view
    }()
    
    // MARK: - function
    private func setupDataSource(){
        whatToPlayView.placeCollectionView.dataSource = self
        whatToPlayView.hotPlaceCollectionView.dataSource = self
    }
    
    // 네비게이션바 추가
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .icon1
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel().then {
            $0.text = "izakaya"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
    }
    
    // 뭐하고 놀지? API 호출
    private func fetchWhatToPlay() {
        let groupName = "izakaya"
        
        APIClient.fetchWhatToPlay(
            groupName: groupName
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self?.stores = response.result.stores.map {
                        StoreModel(
                            storeId: $0.storeId,
                            storeName: $0.storeName,
                            storePic: $0.storePic,
                            storePlace: $0.storePlace,
                            saved: $0.saved
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self?.whatToPlayView
                            .hotPlaceCollectionView
                            .reloadData()
                    }
                } else {
                    print("API 실패: \(response.message)")
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
                if let responseCode = error.responseCode {
                    print("HTTP 상태 코드: \(responseCode)")
                }
            }
        }
    }
}

// MARK: - Action
    
extension WhatToPlayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == whatToPlayView.placeCollectionView{
            return IzakayaModel.dummy().count
        } else if collectionView == whatToPlayView.hotPlaceCollectionView{
            return stores.count
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
            let store = stores[indexPath.row]
            
            if let storePic = store.storePic, let url = URL(string: storePic) {
                cell.placeImageView.kf.setImage(with: url)
            } else {
                cell.placeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
            }
            cell.placeLabel.text = store.storeName
            cell.stationLabel.text = store.storePlace
            return cell
        }
        return UICollectionViewCell()
    }
}
