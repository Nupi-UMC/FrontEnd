//
//  CategoryButtonCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

class CategoryButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryButtonCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    let categoryButton = UIButton().then{
        $0.setTitleColor(.blue4, for: .normal)
        $0.titleLabel?.font = UIFont(name: "WantedSans-Medium", size: 16)
        $0.clipsToBounds = true
        
        $0.backgroundColor = .bg
        
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth  = 1
        $0.layer.borderColor = UIColor.blue1.cgColor
    }
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(categoryButton)
        
        categoryButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
