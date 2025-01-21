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
    let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
//        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        $0.estimatedItemSize = .init(width: 337, height: 115)
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 0
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
    
    // MARK: - Constaints & Add Function
    private func addComponents() {
        addSubview(bannerCollectionView)
    }
    
    private func constraints() {
        bannerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(115)
        }
    }
}
