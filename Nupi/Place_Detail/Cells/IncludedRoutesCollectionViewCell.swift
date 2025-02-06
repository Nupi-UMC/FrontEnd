//
//  IncludedRoutesCollectionViewCell.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class IncludedRoutesCollectionViewCell: UICollectionViewCell {
    static let identifier = "IncludedRoutesCollectionViewCell"
    
    var thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10 // 둥근 모서리 적용
            return imageView
        }()
    
    var routeTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .heading2
        label.textColor = .text1
        return label
    }()
    var routeLocationLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .coffee
        return label
    }()
    var likeCountLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .icon2
        return label
    }()
    var saveCountLabel : UILabel = {
        let label = UILabel()
        label.font = .button3
        label.textColor = .icon2
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
        self.addSubview(thumbnailImageView)
        self.addSubview(routeTitleLabel)
        self.addSubview(routeLocationLabel)
        self.addSubview(likeCountLabel)
        self.addSubview(saveCountLabel)
        
        //  이미지 뷰의 레이아웃 설정 (크기와 위치)
                thumbnailImageView.snp.makeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.height.equalTo(100) // 고정 높이 설정
                }
        routeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(138)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(20)
        }
        routeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(routeTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(23)
            make.width.equalTo(157)
            make.height.equalTo(17)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(routeLocationLabel.snp.trailing).offset(75)
            make.height.equalTo(17)
            
        }
        saveCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(routeLocationLabel)
            make.leading.equalTo(likeCountLabel.snp.trailing).offset(28)
            make.height.equalTo(17)
        }
    }
    /// `Route` 모델을 사용하여 UI 업데이트
        func updateUI(with route: Route) {
            routeTitleLabel.text = route.routeName
            routeLocationLabel.text = route.location
            likeCountLabel.text = "\(route.likeNum)"
            saveCountLabel.text = "\(route.bookmarkNum)"
            
            /*if let imageUrl = route.images?.first {
                thumbnailImageView.loadImage(from: imageUrl)
            } else {
                thumbnailImageView.image = UIImage(named: "placeholder") // 기본 이미지 설정
            }*/
        }
}
