//
//  PlaceReviewsCollectionViewCell.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceReviewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlaceReviewsCollectionViewCell"
    
    private let backgroundRoundedView: UIView = {
            let view = UIView()
            view.backgroundColor = .line1
            view.layer.cornerRadius = 12
            view.layer.masksToBounds = true
            return view
        }()
    
    var profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 24
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nicknameLabel : UILabel = {
        let label = UILabel()
        label.font = .body3
        label.textColor = .blue3
        label.textAlignment = .left
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "ellipsis")?.withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)
            ),
            for: .normal
        )
        button.tintColor = .icon1
        return button
    }()
    
    lazy var reviewLabel : UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .icon1
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0 //줄 수 제한 x
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .icon2
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder){
        fatalError( "init(coder:) has not been implemented" )
    }
    
    private func addComponents(){
        self.contentView.addSubview(backgroundRoundedView)
        backgroundRoundedView.addSubview(profileImage)
        backgroundRoundedView.addSubview(nicknameLabel)
        backgroundRoundedView.addSubview(button)
        backgroundRoundedView.addSubview(reviewLabel)
        backgroundRoundedView.addSubview(dateLabel)
        
        backgroundRoundedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.height.equalTo(19)
        }
        button.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(16)
        }
        reviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage)
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.width.equalTo(313)
            make.height.equalTo(95)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(4)
            make.trailing.equalTo(reviewLabel.snp.trailing)
            make.height.equalTo(16)
        }
    }
    
}
