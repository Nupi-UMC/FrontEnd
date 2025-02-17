//
//  BookmarkedStoreViewController.swift
//  Nupi
//
//  Created by 선가연 on 2/15/25.
//

import UIKit

class BookmarkedStoreViewController: UIViewController {
    
    private var bookmarkedStores: [BookmarkedStoreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = bookmarkedStoreView
        setupDelegate()
        setupNavigationBar()
        fetchBookmarkedStores()
    }
    
    private lazy var bookmarkedStoreView: BookmarkedStoreView = {
        let view = BookmarkedStoreView()
        return view
    }()
    
    private func setupDelegate() {
        bookmarkedStoreView.bookmarkedStoreCollectionView.dataSource = self
    }
    
    // 네비게이션 바 커스텀 함수
    private func setupNavigationBar() {
        // 뒤로가기 버튼 설정
        self.navigationController?.navigationBar.tintColor = .icon1
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // 타이틀 설정
        let titleLabel = UILabel().then {
            $0.text = "저장 장소"
            $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
            $0.textColor = .icon1
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more_vertical_icon"))
    }
    
    // 나의 경로 API 호출
    private func fetchBookmarkedStores() {
        APIClient.fetchBookmarkedStores() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self.bookmarkedStores = response.result.bookmarkedStores.map {
                        BookmarkedStoreModel(
                            storeId: $0.storeId,
                            name: $0.name,
                            location: $0.location,
                            storePic: $0.storePic)
                    }
                    DispatchQueue.main.async {
                        self.bookmarkedStoreView.bookmarkedStoreCollectionView.reloadData()
                        self.updateEmptyState(isEmpty: self.bookmarkedStores.isEmpty)
                    }
                } else {
                    print("Error: \(response.message)")
                    DispatchQueue.main.async {
                        self.updateEmptyState(isEmpty: true)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.updateEmptyState(isEmpty: true)
                }
            }
        }
    }
    
    private func updateEmptyState(isEmpty: Bool) {
        bookmarkedStoreView.emptyIconImageView.isHidden = !isEmpty
        bookmarkedStoreView.emptyLabel.isHidden = !isEmpty
        bookmarkedStoreView.bookmarkedStoreCollectionView.isHidden = isEmpty
    }
}

extension BookmarkedStoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkedStores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookmarkedStoreCollectionViewCell.identifier,
            for: indexPath
        ) as? BookmarkedStoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let place = bookmarkedStores[indexPath.row]
        
        if let placePic = place.storePic, let url = URL(string: placePic) {
            cell.storeImageView.kf.setImage(with: url)
        } else {
            cell.storeImageView.image = UIImage(named: "banner_image1") // 기본 이미지 설정
        }
        
        cell.storeNameLabel.text = place.name
        cell.storeLocationLabel.text = place.location
        
        return cell
    }
}
