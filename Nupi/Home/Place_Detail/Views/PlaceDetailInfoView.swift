//
//  DetailInfoView.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceDetailInfoView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView : UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var locationIconImageView = UIImageView(image: UIImage(named: "location_icon"))
    
    private lazy var timeIconImageView = UIImageView(image: UIImage(named: "time_icon"))
    
    private lazy var timeDivisionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "circle.fill"))
        imageView.tintColor = UIColor.blue4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var phoneIconImageView = UIImageView(image: UIImage(named: "phone_icon"))
    
    private lazy var instagramIconImageView = UIImageView(image: UIImage(named: "instagram_icon"))
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .icon1
        label.text = "서울 마포구 포은로 27 2층"
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .icon1
        label.text = "13시 영업 시작"
        return label
    }()
    
    lazy var closedLabel : UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .rice
        label.text = "월, 화 휴무"
        return label
    }()
    
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .icon1
        label.text = "0507-1368-1536"
        return label
    }()
    
    lazy var instagramLabel : UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .blue2
        label.text = "@_merry_more_"
        return label
    }()
    
    lazy var mapImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func addComponents(){
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(locationIconImageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(timeIconImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeDivisionImageView)
        contentView.addSubview(closedLabel)
        contentView.addSubview(phoneIconImageView)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(instagramIconImageView)
        contentView.addSubview(instagramLabel)
        contentView.addSubview(mapImageView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width) // 세로 스크롤
        }
        
        locationIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(32.23)
            make.width.height.equalTo(19)
        }
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationIconImageView.snp.trailing).offset(4)
            make.centerY.equalTo(locationIconImageView)
        }
        timeIconImageView.snp.makeConstraints { make in
            make.top.equalTo(locationIconImageView.snp.bottom).offset(13)
            make.leading.equalTo(locationIconImageView)
            make.width.height.equalTo(19)

        }
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeIconImageView)
            make.leading.equalTo(locationLabel)
        }
        timeDivisionImageView.snp.makeConstraints { make in
            make.centerY.equalTo(timeIconImageView)
            make.width.height.equalTo(3)
            make.leading.equalTo(timeLabel.snp.trailing).offset(6)
        }
        closedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeIconImageView)
            make.leading.equalTo(timeDivisionImageView.snp.trailing).offset(6)
        }
        phoneIconImageView.snp.makeConstraints { make in
            make.top.equalTo(timeIconImageView.snp.bottom).offset(13)
            make.leading.equalTo(locationIconImageView)
            make.width.height.equalTo(19)

        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneIconImageView)
            make.leading.equalTo(locationLabel)
        }
        instagramIconImageView.snp.makeConstraints{ make in
            make.top.equalTo(phoneIconImageView.snp.bottom).offset(13)
            make.leading.equalTo(locationIconImageView)
            make.width.height.equalTo(19)

        }
        instagramLabel.snp.makeConstraints { make in
            make.centerY.equalTo(instagramIconImageView)
            make.leading.equalTo(locationLabel)
        }
        
        mapImageView.snp.makeConstraints { make in
            make.top.equalTo(instagramLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.width.equalTo(337)
            make.height.equalTo(220)
            make.bottom.equalToSuperview().inset(24)
        }
    }

}
