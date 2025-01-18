//
//  PlaceDetailHeaderView.swift
//  Nupi
// 
//  Created by Dana Lim on 1/18/25.
//

import UIKit
import SnapKit

class PlaceDetailHeaderView: UIView {
    
    // UI Components
    private let imageSlider = UIScrollView()
    lazy var titleLabel = UILabel()
    lazy var categoryLabel = UILabel()
    let locationImageView = UIImageView()
    lazy var locationLabel = UILabel()
    let shareButton = UIButton()
    let likeButton = UIButton()
    lazy var likeLabel = UILabel()
    let saveButton = UIButton()
    lazy var saveLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        self.backgroundColor = .bg
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 기본 설정
        imageSlider.isPagingEnabled = true
        imageSlider.showsHorizontalScrollIndicator = false
        
        titleLabel.font = .heading3
        titleLabel.textColor = .blue3
        titleLabel.text = "메리모어"
        
        categoryLabel.font = .button2
        categoryLabel.textColor = .icon2
        categoryLabel.text = "키덜트 샵"
        
        locationImageView.tintColor = .coffee
        locationImageView.image = UIImage(named:"round_place")
        
        locationLabel.font = .button2
        locationLabel.textColor = .coffee
        locationLabel.text = "성수역 1번 출구"
        
        likeButton.setImage(UIImage(named: "like_button"), for: .normal)
        likeLabel.font = .button3
        likeLabel.textColor = .icon2
        likeLabel.text = "389"
        
        shareButton.setImage(UIImage(named:"share_button"), for: .normal)
        
        saveButton.setImage(UIImage(named: "save_button"), for: .normal)
        saveLabel.font = .button3
        saveLabel.textColor = .icon2
        saveLabel.text = "389"
        
        // Add Subviews
        addSubview(imageSlider)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(likeButton)
        addSubview(likeLabel)
        addSubview(shareButton)
        addSubview(saveButton)
        addSubview(saveLabel)
    }
    
    private func setupConstraints() {
            imageSlider.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(335)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(imageSlider.snp.bottom).offset(24)
                make.leading.equalToSuperview().offset(27)
                make.height.equalTo(26)
            }
            
            categoryLabel.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.bottom)
                make.leading.equalTo(titleLabel.snp.trailing).offset(6)
                make.height.equalTo(18)
            }
            
            locationImageView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(14)
                make.leading.equalTo(titleLabel.snp.leading)
                make.size.equalTo(CGSize(width: 19, height: 19)) // 아이콘 크기 설정
            }
            
            locationLabel.snp.makeConstraints { make in
                make.centerY.equalTo(locationImageView)
                make.leading.equalTo(locationImageView.snp.trailing).offset(3)
            }
            
            likeButton.snp.makeConstraints { make in
                make.top.equalTo(imageSlider.snp.bottom).offset(91)
                make.trailing.equalToSuperview().offset(-115)
                make.width.height.equalTo(19)
            }
            
            likeLabel.snp.makeConstraints { make in
                make.centerY.equalTo(likeButton)
                make.leading.equalTo(likeButton.snp.trailing).offset(3)
            }
            
            shareButton.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalToSuperview().inset(28.25)
                make.width.height.equalTo(24)
            }
            
            saveButton.snp.makeConstraints { make in
                make.centerY.equalTo(likeButton)
                make.trailing.equalToSuperview().offset(-57)
                make.width.height.equalTo(19)
            }
            
            saveLabel.snp.makeConstraints { make in
                make.centerY.equalTo(saveButton)
                make.leading.equalTo(saveButton.snp.trailing).offset(3)
            }
        }
}
