//
//  ActivityExplorationView.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit
import SnapKit
import Then

class ActivityExplorationView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    // 광고 배너 컬렉션 뷰
    let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 337, height: 115)
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }

    // 카테고리 컬렉션 뷰
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
//        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 8
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    // 구분 선
    private let divideLine = UIView().then {
        $0.backgroundColor = .grey1
    }
    
    // 가게 컬렉션 뷰
    let storeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 163, height: 174)
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 11
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: StoreCollectionViewCell.identifier)
    }
    
    // MARK: - Constaints & Add Function
    private func addComponents() {
        addSubview(bannerCollectionView)
        addSubview(categoryCollectionView)
        addSubview(divideLine)
        addSubview(storeCollectionView)
    }
    
    private func constraints() {
        bannerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(115)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(bannerCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(29)
        }
        
        divideLine.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(1)
        }
        
        storeCollectionView.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalToSuperview()
        }
    }
}
