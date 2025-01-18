//
//  HomeView.swift
//  Nupi
//
//  Created by 신연주 on 1/9/25.
//

import UIKit
import SnapKit
import Then

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 스크롤뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView()
    
    // MARK: 배너
    //컬렉션뷰
    let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 393, height: 408)
        $0.minimumLineSpacing = 0}).then{
            $0.backgroundColor = .clear
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = true
            $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
    
    //상단 로고
    private let logoLabel = UILabel().then {
        $0.font = UIFont(name: "EF_jejudoldam", size: 32)
        $0.textColor = .white
        $0.text = "NUPI"
    }
    
    // MARK: 버튼
    //놀거리 탐색 버튼
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("놀거리 탐색", for: .normal)
        button.setTitleColor(.grey1, for: .normal)
        button.setTitleColor(.grey2, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.backgroundColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1).cgColor
        button.layer.cornerRadius = 11
        
        button.setImage(UIImage(named:"my_path_image"), for: .normal)
        
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor, constant: 8).isActive = true
        button.imageView?.leftAnchor.constraint(equalToSystemSpacingAfter: button.leftAnchor, multiplier: 10).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //나의 경로 버튼
    private lazy var myPathButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("나의 경로", for: .normal)
        button.setTitleColor(.grey1, for: .normal)
        button.setTitleColor(.grey2, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.backgroundColor = UIColor(red:63/255,green:66/255,blue:76/255,alpha: 1).cgColor
        button.layer.cornerRadius = 11
        
        button.setImage(UIImage(named:"search_button_image"), for: .normal)
        
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor, constant: 8).isActive = true
        button.imageView?.leftAnchor.constraint(equalToSystemSpacingAfter: button.leftAnchor, multiplier: 13).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    // MARK: Upcomming Schedule
    // upcomming타이틀
    private let upcommingTitle = UILabel().then {
        $0.text = "Upcomming Schedule"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    //화살표 이미지
    private let vectorIcon = UIImageView().then {
        $0.image = UIImage(named: "vector_icon")
    }
    
    //upcomming 버튼
    private let upcommingButton = UIButton().then {
        $0.setTitle("나님의 생일파티~!!", for: .normal)
        $0.setTitleColor(.blue3 , for: .normal)
        $0.titleLabel?.font = UIFont(name: "WantedSans-Medium", size: 17)
        
        $0.setImage(UIImage(named:"partying_face"), for: .normal)
        // 이미지의 위치 조정
        $0.imageEdgeInsets = UIEdgeInsets(top: 18, left: 34, bottom: 18, right: 259)
        // 텍스트의 위치 조정
        $0.titleEdgeInsets = UIEdgeInsets(top: 24, left: -44, bottom: 44, right: 0)
        // 버튼의 콘텐츠 경계 설정
        //$0.contentEdgeInsets = UIEdgeInsets(top: 18, left: 34, bottom: 0, right: 18)
                
        $0.layer.borderColor = UIColor.blue1.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 11
    }
    
    //디데이 라벨
    private let dDayLabel = UILabel().then {
        $0.text = "D-7"
        $0.textColor = .blue4
        $0.font = UIFont(name: "WantedSans-Medium", size: 13)
    }
    
    //동그라미 이미지
    private let circleImage = UIImageView().then {
        $0.image = UIImage(systemName: "circlebadge.fill")
        $0.tintColor = .blue4
    }
    
    //날짜 라벨
    private let dateLabel = UILabel().then {
        $0.text = "~2024.12.24"
        $0.textColor = .blue4
        $0.font = UIFont(name: "WantedSans-Medium", size: 13)
    }
    

    // MARK: 뭐하고 놀지?
    private let whatToPlayTitle = UILabel().then {
        $0.text = "뭐하고 놀지?"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    //컬렉션뷰
    let whatToPlayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 172, height: 186)
        $0.minimumLineSpacing = 8}).then{
            $0.backgroundColor = .clear
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = true
            $0.register(WhatToPlayCollectionViewCell.self, forCellWithReuseIdentifier: WhatToPlayCollectionViewCell.identifier)
        }
    
    // MARK: 어디서 놀지?
    //타이틀
    private let whereToPlayTitle = UILabel().then {
        $0.text = "어디서 놀지?"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    // MARK: Our Memories
    //타이틀
    private let ourMemoriesTitle = UILabel().then {
        $0.text = "Our Memories"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    //화살표 이미지
    private let vectorIcon2 = UIImageView().then {
        $0.image = UIImage(named: "vector_icon")
    }
    //컬렉션뷰
    let ourMemoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 172, height: 186)
        $0.minimumLineSpacing = 8}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = true
            $0.register(OurMemoriesCollectionViewCell.self, forCellWithReuseIdentifier: OurMemoriesCollectionViewCell.identifier)
    }
    // MARK: Steady Popular Spot 타이틀
    /*
    private lazy var steadyTitle: UILabel = {
        let label = UILabel()
        
        label.text = "Steady Popular Spot"
        label.textColor = UIColor(red:53/255,green:62/255,blue:81/255,alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    //Steady Popular Spot 스택뷰
    public lazy var steadyTableView: UITableView = {
        let table = UITableView()
        
        table.register(SteadyPopularSpotCell.self, forCellReuseIdentifier: SteadyPopularSpotCell.identifier)
        table.separatorStyle = .none
        return table
    }()
     */
    
    // MARK: 컴포넌트 추가
    private func setViews(){
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2357)
        }

        contentView.addSubview(bannerCollectionView)
        contentView.addSubview(logoLabel)
        contentView.addSubview(searchButton)
        contentView.addSubview(myPathButton)
        contentView.addSubview(upcommingTitle)
        contentView.addSubview(vectorIcon)
        contentView.addSubview(upcommingButton)
        contentView.addSubview(dDayLabel)
        contentView.addSubview(circleImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(whatToPlayTitle)
        contentView.addSubview(whatToPlayCollectionView)
        contentView.addSubview(whereToPlayTitle)
        contentView.addSubview(ourMemoriesTitle)
        contentView.addSubview(vectorIcon2)
        contentView.addSubview(ourMemoriesCollectionView)
        //self.addSubview(steadyTitle)
        //self.addSubview(steadyTableView)
        
        logoLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(62)
            $0.left.equalToSuperview().offset(24)
            
        }
        bannerCollectionView.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.horizontalEdges.equalToSuperview()
            $0.width.equalTo(393)
            $0.height.equalTo(408)
        }
        
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
        
        upcommingTitle.snp.makeConstraints{
            $0.top.equalTo(searchButton.snp.bottom).offset(44)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(209)
            $0.height.equalTo(24)
        }
        
        vectorIcon.snp.makeConstraints{
            $0.top.equalTo(upcommingTitle.snp.top).offset(5.66)
            $0.left.equalTo(upcommingTitle.snp.right).offset(0)
            $0.width.equalTo(5.8)
            $0.height.equalTo(12.69)
        }
        upcommingButton.snp.makeConstraints{
            $0.top.equalTo(upcommingTitle.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(88)
        }
        
        dDayLabel.snp.makeConstraints{
            $0.top.equalTo(upcommingButton.snp.top).offset(48)
            $0.left.equalTo(upcommingButton.snp.left).offset(111)
        }
        
        circleImage.snp.makeConstraints{
            $0.top.equalTo(upcommingButton.snp.top).offset(54.5)
            $0.left.equalTo(dDayLabel.snp.right).offset(6)
            $0.width.equalTo(3)
            $0.height.equalTo(3)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(upcommingButton.snp.top).offset(48)
            $0.left.equalTo(dDayLabel.snp.right).offset(15)
        }
        
        whatToPlayTitle.snp.makeConstraints{
            $0.top.equalTo(upcommingButton.snp.bottom).offset(44)
            $0.left.equalToSuperview().offset(24)
        }
        
        whatToPlayCollectionView.snp.makeConstraints{
            $0.top.equalTo(whatToPlayTitle.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(186)
        }
        
        whereToPlayTitle.snp.makeConstraints{
            $0.top.equalTo(whatToPlayCollectionView.snp.bottom).offset(44)
            $0.left.equalToSuperview().offset(24)
        }
        
        ourMemoriesTitle.snp.makeConstraints{
            $0.top.equalTo(whereToPlayTitle.snp.bottom).offset(137)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        vectorIcon2.snp.makeConstraints{
            $0.top.equalTo(ourMemoriesTitle.snp.top).offset(6.66)
            $0.left.equalTo(ourMemoriesTitle.snp.right).offset(8.53)
            $0.width.equalTo(5.8)
            $0.height.equalTo(12.69)
        }
        
        ourMemoriesCollectionView.snp.makeConstraints{
            $0.top.equalTo(ourMemoriesTitle.snp.bottom).offset(14)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(186)
        }
    

        /*
        steadyTitle.snp.makeConstraints{
            $0.top.equalTo(searchButton.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(24)
        }
        
        steadyTableView.snp.makeConstraints{
            $0.top.equalTo(steadyTitle.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(450)
        }
         */
    }
}

