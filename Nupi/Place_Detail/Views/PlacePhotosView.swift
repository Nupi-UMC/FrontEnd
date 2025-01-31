//
//  PhotosView.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlacePhotosView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     lazy var placePhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 세로 스크롤
        layout.minimumLineSpacing = 4 // 셀 간의 세로 간격
        layout.minimumInteritemSpacing = 4 // 셀 간의 가로 간격
        layout.itemSize = CGSize(width: 120, height: 120) // 셀 크기
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PlacePhotosCollectionViewCell.self, forCellWithReuseIdentifier: PlacePhotosCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear // 배경색
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private func addComponents(){
        self.addSubview(placePhotosCollectionView)
        
        placePhotosCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(24)
        }
    }

}
