//
//  WhereToPlayCollectionViewCell.swift
//  Nupi
//
//  Created by 신연주 on 1/19/25.
//

import UIKit

class WhereToPlayCollectionViewCell: UICollectionViewCell {
    static let identifier = "WhereToPlayCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //버튼
    let whereToPlayButton = UIButton().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setImage(UIImage(named: "arround_me_image"), for: .normal)
        $0.layer.cornerRadius = 38
    }
    
    //장소
    let whereToPlayLabel = UILabel().then{
        $0.text = "내 주변"
        $0.textColor = .white
        $0.font = UIFont(name: "WantedSans-Regular", size: 16)
    }
    
    // MARK: 컴포넌트 추가
    private func setupView() {
        addSubview(whereToPlayButton)
        addSubview(whereToPlayLabel)
        
        whereToPlayButton.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.left.horizontalEdges.equalToSuperview()
            $0.width.equalTo(76)
            $0.height.equalTo(76)
        }
        
        whereToPlayLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(28.5)
            $0.centerX.equalToSuperview()
        }
    }
}
