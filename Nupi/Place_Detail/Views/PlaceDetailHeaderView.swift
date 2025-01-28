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
    private let pageIndicatorLabel : UILabel = {
        let label = UILabel()
        label.font = .tabbar1
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        label.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.65)

        return label
    }()
    private var imageURLs: [String] = []
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
    
    private func updatePageIndicatorLabel(currentPage: Int) {
        let totalPages = imageURLs.count
        pageIndicatorLabel.text = "\(currentPage + 1)/\(totalPages)"
    }
    
    
     func setUpImageSlider() {
        imageSlider.subviews.forEach { $0.removeFromSuperview() } // 기존 이미지 제거

        let sampleImages = [
            UIImage(named: "ex2"), // 프로젝트에 추가된 로컬 이미지
            UIImage(named: "ex2"),
            UIImage(named: "ex2"),
            UIImage(named: "ex2")
        ]
        
        for (index, image) in sampleImages.enumerated() {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = image // 이미지 설정
            imageSlider.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalToSuperview()
                make.leading.equalToSuperview().offset(CGFloat(index) * self.frame.width)
            }
        }

        // 스크롤뷰의 컨텐츠 사이즈 설정
        imageSlider.contentSize = CGSize(width: CGFloat(sampleImages.count) * self.frame.width, height: 335)

    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl){
        let offset = CGFloat(sender.currentPage) * imageSlider.frame.width
            imageSlider.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    private func setupUI() {
        // 기본 설정
        imageSlider.isPagingEnabled = true
        imageSlider.showsHorizontalScrollIndicator = false
        imageSlider.showsVerticalScrollIndicator = false
        imageSlider.delegate = self
        
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
        addSubview(pageIndicatorLabel)
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
        pageIndicatorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageSlider.snp.bottom).inset(15)
            make.width.equalTo(46)
            make.height.equalTo(27)
            make.centerX.equalToSuperview()
        }
        }
}

extension PlaceDetailHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        updatePageIndicatorLabel(currentPage: pageIndex)
    }
    
}
