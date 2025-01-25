//
//  ButtonCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/25/25.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "ButtonCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    let button = UIButton().then{
        $0.setTitle("전체", for: .normal)
        $0.tintColor = .blue4
        
        $0.backgroundColor = .bg
        
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth  = 1
        $0.layer.borderColor = UIColor(named: ".grey2")?.cgColor
    }
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(button)
        
        button.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(52)
            $0.height.equalTo(29)
        }
    }
}
