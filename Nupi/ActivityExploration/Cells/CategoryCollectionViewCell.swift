//
//  CategoryCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var categoryButton = UIButton().then {
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.blue1.cgColor
        $0.titleLabel?.font = UIFont(name: "WantedSans-Medium", size: 16)
        $0.setTitleColor(.blue4, for: .normal)
        $0.backgroundColor = .bg
    }

    
    private func setupView() {
        // 서브뷰 추가
        addSubview(categoryButton)
        
        // 레이아웃 설정
        categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
