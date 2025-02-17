//
//  BookmarkedStoreView.swift
//  Nupi
//
//  Created by 선가연 on 2/15/25.
//

import UIKit

class BookmarkedStoreView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    // 컨텐트 뷰
    private let contentView = UIView()
    
    // 저장 장소 컬렉션 뷰
    let bookmarkedStoreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        print(UIScreen.main.bounds.width)
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - 28 * 2 - 11) / 2
        $0.itemSize = CGSize(width: itemWidth, height: 174)
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 11
        $0.sectionInset = UIEdgeInsets(top: 20, left: 28, bottom: 20, right: 28)
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookmarkedStoreCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkedStoreCollectionViewCell.identifier)
    }
    
    let emptyIconImageView = UIImageView().then {
        $0.image = .emptyFolderIcon
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "저장된 장소가 없습니다."
        $0.font = .body4
        $0.textColor = .icon2
    }
    
    private func setViews() {
        // 컴포넌트 추가
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookmarkedStoreCollectionView)
        contentView.addSubview(emptyIconImageView)
        contentView.addSubview(emptyLabel)
        
        // 레이아웃 설정
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
        
        bookmarkedStoreCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        emptyIconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(32)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyIconImageView.snp.bottom).offset(18)
        }
    }

}
