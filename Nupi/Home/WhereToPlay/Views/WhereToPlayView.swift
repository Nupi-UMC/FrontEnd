//
//  WhereToPlayView.swift
//  Nupi
//
//  Created by 신연주 on 1/25/25.
//

import UIKit

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
    
    // 뒤로가기 버튼
    private let backButton = UIButton().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setImage(UIImage(systemName: "chevron.backward"),for: .normal)
        $0.tintColor = .icon1
    }
    
    // 상단 타이틀
    private let titleLabel = UILabel().then {
        $0.text = "Hongdae"
        $0.textColor = .icon1
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 17)
    }
    
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
    
    // 테마 선택 버튼 컬렉션뷰
    // 정렬 버튼
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
            $0.height.equalTo(1600)
        }
        
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(placeCollectionView)
        contentView.addSubview(separatorLine)
        contentView.addSubview(placeSortedCollectionView)
        
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
        
        placeSortedCollectionView.snp.makeConstraints{
            $0.top.equalTo(separatorLine.snp.bottom).offset(121)
            $0.left.right.equalToSuperview().inset(28)
            $0.width.equalTo(337)
            $0.height.equalTo(368)
        }
    }
}
