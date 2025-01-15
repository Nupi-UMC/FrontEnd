//
//  SteadyPopularSpotCell.swift
//  Nupi
//
//  Created by 신연주 on 1/11/25.
//

import UIKit
import SnapKit

class SteadyPopularSpotCell: UITableViewCell {
    static let identifier = "SteadyPopualrSpotCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
        self.setConstrains()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.spotImage.image = nil
        self.spotName.text = nil
        self.spotAddress.text = nil
        self.spotStation.text = nil
        self.spotDescription.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    //spot 이미지
    private lazy var spotImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    //spot 이름
    private lazy var spotName: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .black
        
        return label
    }()
    
    //spot 이미지
    private lazy var spotIcon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named:"spot_icon")
        return imageView
    }()
    
    //spot 주소
    private lazy var spotAddress: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1)
        
        return label
    }()
    //원 이미지
    
    //spot 역
    private lazy var spotStation: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1)
        
        return label
    }()
    
    //spot 설명
    private lazy var spotDescription: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red:83/255,green:95/255,blue:122/255,alpha: 1)
        
        return label
    }()
    
    // MARK: 컴포넌트 배치
    private func setView(){
        self.addSubview(spotImage)
        self.addSubview(spotName)
        self.addSubview(spotIcon)
        self.addSubview(spotAddress)
        self.addSubview(spotStation)
        self.addSubview(spotDescription)
    }
    
    private func setConstrains(){
        spotImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        
        spotName.snp.makeConstraints {
            $0.top.equalTo(spotImage.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        spotIcon.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        spotAddress.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(12.5)
            $0.left.equalTo(spotIcon.snp.right).offset(6)
        }
        
        spotStation.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(12.5)
            $0.left.equalTo(spotAddress.snp.right).offset(13)
        }
        
        spotDescription.snp.makeConstraints {
            $0.top.equalTo(spotAddress.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(331)
            $0.height.equalTo(272)
        }
    }
    
    // MARK: - 값 설정
    private func configure(model:SteadyPopularSpotModel){
        self.spotImage.image = UIImage(named: model.spotImage)
        self.spotName.text = model.spotName
        self.spotAddress.text = model.spotAddress
        self.spotStation.text = model.spotStation
        self.spotDescription.text = model.spotDescription
    }
}
