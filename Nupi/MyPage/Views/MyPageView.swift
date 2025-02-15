//
//  MyPageView.swift
//  Nupi
//
//  Created by 신연주 on 1/9/25.
//

import UIKit
import SnapKit

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
    
    // 프로필 영역
    let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.estimatedItemSize = .init(width: 345, height: 80)}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        }
    
    // 버튼 영역
    
    // 상단 구분선
    private let separatorLine = UIView().then{
        $0.backgroundColor = .line1
    }
    
    // 메뉴 영역
    
    // 하단 구분선
    // MARK: 컴포넌트 추가
    private func setViews(){
        addSubview(profileCollectionView)
        addSubview(separatorLine)
        
        profileCollectionView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        
        separatorLine.snp.makeConstraints{
            $0.top.equalTo(profileCollectionView.snp.bottom).offset(113)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(1)
        }
    }
}
