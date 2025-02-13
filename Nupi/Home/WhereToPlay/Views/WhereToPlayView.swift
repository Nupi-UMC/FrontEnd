//
//  WhereToPlayView.swift
//  Nupi
//
//  Created by 신연주 on 1/25/25.
//

import UIKit
import SnapKit

class WhereToPlayView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView()
    
    // 홍대 컬렉션뷰
    let placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 345, height: 424)
        $0.minimumLineSpacing = 32}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(HongdaeCollectionViewCell.self, forCellWithReuseIdentifier: HongdaeCollectionViewCell.identifier)
        }
    
    // 구분선
    private let separatorLine = UIView().then{
        $0.backgroundColor = .line1
    }
    
    // 카테고리 선택 버튼 컬렉션뷰
    let categoryButtonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 8
        $0.sectionInset = UIEdgeInsets(top: 16, left: 28, bottom: 16, right: 28)
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.identifier)
    }
    
    // 구분선
    private let separatorLine2 = UIView().then{
        $0.backgroundColor = .grey1
    }
    
    // 드롭다운 버튼
    lazy var dropdownButton = UIButton().then {
        $0.setTitle("기본 ", for: .normal)
        $0.setTitleColor(.icon2, for: .normal)
        $0.titleLabel?.font = UIFont(name: "WantedSans-Regular", size: 15)
        $0.setImage(UIImage(named: "down_icon"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    // 테마별 컬렉션뷰
    let placeSortedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 163, height: 174)
        $0.minimumLineSpacing = 11}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(HongdaeSortedCollectionViewCell.self, forCellWithReuseIdentifier: HongdaeSortedCollectionViewCell.identifier)
        }
    
    // MARK: 컴포넌트 추가
    private func setViews(){
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(placeCollectionView)
        contentView.addSubview(separatorLine)
        contentView.addSubview(categoryButtonCollectionView)
        contentView.addSubview(separatorLine2)
        contentView.addSubview(dropdownButton)
        contentView.addSubview(placeSortedCollectionView)
        
        placeCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalTo(contentView).inset(24)
            $0.height.equalTo(880)
        }
        
        separatorLine.snp.makeConstraints{
            $0.top.equalTo(placeCollectionView.snp.bottom).offset(41)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(11)
        }
        
        categoryButtonCollectionView.snp.makeConstraints{
            $0.top.equalTo(separatorLine.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(61)
        }
        
        separatorLine2.snp.makeConstraints{
            $0.top.equalTo(categoryButtonCollectionView.snp.bottom)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-28)
            $0.height.equalTo(1)
        }
        
        dropdownButton.snp.makeConstraints {
            $0.top.equalTo(separatorLine2.snp.bottom).offset(13)
            $0.right.equalToSuperview().offset(-28)
        }
        
        placeSortedCollectionView.snp.makeConstraints{
            $0.top.equalTo(dropdownButton.snp.bottom).offset(28)
            $0.leading.trailing.equalTo(contentView).inset(28)
            $0.height.equalTo(368)
        }
    }
}
