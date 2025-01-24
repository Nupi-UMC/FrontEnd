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
    
    // 뒤로가기 버튼
    let backButton = UIButton().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setImage(UIImage(systemName: "chevron.backward"),for: .normal)
        $0.tintColor = .icon1
    }
    
    // 상단 타이틀
    private let titleLabel = UILabel().then {
        $0.text = "izakaya"
        $0.textColor = .icon1
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
    }
    
    // 컬렉션뷰
    let placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
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
    
    // 테이블뷰
    
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
            $0.height.equalTo(1700)
        }
        
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(placeCollectionView)
        contentView.addSubview(separatorLine)
        contentView.addSubview(subTitleLabel)
        
        backButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        placeCollectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
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
    }
}

