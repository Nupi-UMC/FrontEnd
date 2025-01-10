//
//  HomeView.swift
//  Nupi
//
//  Created by 신연주 on 1/9/25.
//

import UIKit
import SnapKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setViews()
        self.setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    //놀거리 탐색 버튼
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("놀거리 탐색", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.backgroundColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1).cgColor
        button.layer.cornerRadius = 11
        
        button.setImage(UIImage(named:"my_path_image"), for: .normal)
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor, constant: 8).isActive = true
        button.imageView?.leftAnchor.constraint(equalToSystemSpacingAfter: button.leftAnchor, multiplier: 10).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //나의 경로 버튼
    private lazy var myPathButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("나의 경로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.backgroundColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1).cgColor
        button.layer.cornerRadius = 11
        
        button.setImage(UIImage(named:"search_button_image"), for: .normal)
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor, constant: 8).isActive = true
        button.imageView?.leftAnchor.constraint(equalToSystemSpacingAfter: button.leftAnchor, multiplier: 13).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //Upcomming Schedule
    //뭐하고 놀지?
    //어디서 놀지?
    //Our Memories
    //Steady Popular Spot
    // MARK: 컴포넌트 추가
    private func setViews(){
        self.addSubview(searchButton)
        self.addSubview(myPathButton)
    }
    
    private func setConstaints(){
        searchButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(449)
            $0.left.equalToSuperview().offset(58)
            $0.width.equalTo(131)
            $0.height.equalTo(41)
        }
        
        myPathButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(449)
            $0.left.equalTo(searchButton.snp.right).offset(20)
            $0.width.equalTo(131)
            $0.height.equalTo(41)
        }
    }
}
