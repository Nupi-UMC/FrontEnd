//
//  WhatToPlayView.swift
//  Nupi
//
//  Created by 신연주 on 1/24/25.
//

import UIKit

class WhatToPlayView: UIView {
    
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
    
    
    // 이자카야 컬렉션뷰
    let placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 345, height: 424)
        $0.minimumLineSpacing = 32}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(IzakayaCollectionViewCell.self, forCellWithReuseIdentifier: IzakayaCollectionViewCell.identifier)
        }
    
    // 구분선
    private let separatorLine = UIView().then{
        $0.backgroundColor = .line1
    }
    
    // 지금 핫한 이자카야 타이틀
    private let subTitleLabel = UILabel().then {
        $0.text = "지금 핫한 이자카야 🔥"
        $0.textColor = .black
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 22)
    }
    
    // 핫이자카야 컬렉션뷰
    let hotPlaceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 163, height: 174)
        $0.minimumLineSpacing = 11}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(HotIzakayaCollectionViewCell.self, forCellWithReuseIdentifier: HotIzakayaCollectionViewCell.identifier)
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
            $0.height.equalTo(1768)
        }
        
        contentView.addSubview(placeCollectionView)
        contentView.addSubview(separatorLine)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(hotPlaceCollectionView)
        
        placeCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(880)
        }
        
        separatorLine.snp.makeConstraints{
            $0.top.equalTo(placeCollectionView.snp.bottom).offset(41)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(11)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(separatorLine.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(28)
        }
        
        hotPlaceCollectionView.snp.makeConstraints{
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.left.right.equalToSuperview().inset(28)
            $0.width.equalTo(337)
            $0.height.equalTo(562)
        }
    }
}

