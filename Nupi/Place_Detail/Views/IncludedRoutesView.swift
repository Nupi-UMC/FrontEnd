//
//  IncludedRoutesView.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class IncludedRoutesView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var includedRoutesCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical // 세로 스크롤
       layout.minimumLineSpacing = 32 // 셀 간의 세로 간격
       layout.itemSize = CGSize(width: 345, height: 190) // 셀 크기
       
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.register(IncludedRoutesCollectionViewCell.self, forCellWithReuseIdentifier: IncludedRoutesCollectionViewCell.identifier)
       collectionView.backgroundColor = .clear // 배경색
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.showsVerticalScrollIndicator = false
       return collectionView
   }()
    
    private func addComponents(){
        self.addSubview(includedRoutesCollectionView)
        includedRoutesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(28)
        }
    }
}
