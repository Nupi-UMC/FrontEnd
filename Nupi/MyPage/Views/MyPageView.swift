//
//  MyPageView.swift
//  Nupi
//
//  Created by 신연주 on 1/9/25.
//

import UIKit
import SnapKit
import Then

class MyPageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    // 타이틀 라벨
    private let titleLabel = UILabel().then{
        $0.text = "MY Page"
        $0.textColor = .icon1
        $0.font = UIFont(name: "WantedSans-Medium", size: 17)
    }
    
    // 프로필 컬렉션뷰
    let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 345, height: 80)}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        }
    
    // 메뉴 버튼 컬렉션뷰
    private let menuButtonBackground = UIView().then {
        $0.backgroundColor = .line1
        $0.layer.cornerRadius = 15
    }

    public let menuButtonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 49, height: 51)
        $0.minimumLineSpacing = 124
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(MenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: MenuButtonCollectionViewCell.identifier)
    }
    
    // 상단 구분선
    private let separatorLine = UIView().then{
        $0.backgroundColor = .line1
    }
    
    // 메뉴 컬렉션뷰
    public let settingMenuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.estimatedItemSize = .init(width: 345, height: 23)
        $0.minimumLineSpacing = 28
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(SettingsMenuCollectionViewCell.self, forCellWithReuseIdentifier: SettingsMenuCollectionViewCell.identifier)
    }
    
    // 하단 구분선
    private let separatorLine2 = UIView().then{
        $0.backgroundColor = .line1
    }
    
    // 로그인, 로그아웃 버튼
    private let logoutButton = UIButton().then{
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(UIColor.icon1, for: .normal)
        $0.titleLabel?.font = UIFont(name: "WantedSans-Regular", size: 15)
    }
    
    // MARK: 컴포넌트 추가
    private func setViews(){
        addSubview(titleLabel)
        addSubview(profileCollectionView)
        addSubview(separatorLine)
        addSubview(menuButtonBackground)
        addSubview(menuButtonCollectionView)
        addSubview(settingMenuCollectionView)
        addSubview(separatorLine2)
        addSubview(logoutButton)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(71)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        profileCollectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        
        menuButtonBackground.snp.makeConstraints{
            $0.top.equalTo(profileCollectionView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(79)
        }
        
        menuButtonCollectionView.snp.makeConstraints {
            $0.top.equalTo(menuButtonBackground.snp.top).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(229)
            $0.height.equalTo(51)
        }
        
        separatorLine.snp.makeConstraints{
            $0.top.equalTo(menuButtonBackground.snp.bottom).offset(20)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
        }
        
        settingMenuCollectionView.snp.makeConstraints{
            $0.top.equalTo(separatorLine.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(227)
        }
        
        separatorLine2.snp.makeConstraints{
            $0.top.equalTo(settingMenuCollectionView.snp.bottom).offset(56)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
        }
        
        logoutButton.snp.makeConstraints{
            $0.top.equalTo(separatorLine2.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
        
    }
}
