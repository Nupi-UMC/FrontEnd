//
//  OurMemoriesCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/16/25.
//

import UIKit
import Then

class OurMemoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "OurMemoriseCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    //이미지
    let memoriesimageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
            
    }
    
    //날짜
    let dateLabel = UILabel().then{
        $0.font = UIFont(name: "WantedSans-Regular", size: 16)
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.textColor = .white
        $0.text = "23.10.07"
    }
    
    // MARK: 컴포넌트 추가
    private func setupView() {
        addSubview(memoriesimageView)
        addSubview(dateLabel)
        
        memoriesimageView.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.equalTo(172)
            $0.height.equalTo(186)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(memoriesimageView.snp.bottom).inset(8.39)
            $0.left.equalTo(memoriesimageView.snp.left).offset(7)
        }
    }
}
