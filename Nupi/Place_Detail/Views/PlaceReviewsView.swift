//
//  ReviewsView.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceReviewsView: UIView {
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let writeReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("후기쓰기", for: .normal)
        button.setTitleColor(.icon2, for: .normal)
        button.titleLabel?.font = .caption2
        
        // 🔹 아이콘 추가
        let image = UIImage(named: "pencil_icon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        
        // 🔹 이미지가 오른쪽에 오도록 설정
        button.semanticContentAttribute = .forceRightToLeft
        
        // 🔹 텍스트와 이미지 사이 간격 2pt 설정
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)

        return button
    }()
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 후기가 없어요."
        label.textColor = .icon2
        label.font = .body4
        return label
    }()
    
    private let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = .icon2
        return view
    }()
    
    private func addComponents(){
        self.addSubview(writeReviewButton)
        self.addSubview(lineView)
        self.addSubview(reviewsLabel)
        
        writeReviewButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(writeReviewButton.snp.bottom)
            make.height.equalTo(1)
            make.width.equalTo(64)
            make.leading.equalTo(writeReviewButton)
            make.trailing.equalToSuperview().inset(24)
            
        }
        reviewsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    
}
