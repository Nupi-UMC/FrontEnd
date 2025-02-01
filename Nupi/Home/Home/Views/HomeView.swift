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
        self.backgroundColor = .bg
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    // MARK: 스크롤뷰
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView()
    
    // MARK: 상단배너
    // scrollToTop 버튼
    let scrollToTopButton = UIButton().then{
        $0.backgroundColor = .icon1
        $0.setImage(UIImage(named: "scroll_to_top_icon"), for: .normal)
        $0.clipsToBounds = true
        
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor.white2.cgColor
        $0.layer.borderWidth = 1.79
    }
    
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
    
    // MARK: 상단버튼
    //놀거리 탐색 버튼
    lazy var searchButton: UIButton = {
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
    lazy var myRouteButton: UIButton = {
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
            $0.showsHorizontalScrollIndicator = false
            $0.register(WhatToPlayCollectionViewCell.self, forCellWithReuseIdentifier: WhatToPlayCollectionViewCell.identifier)
        }
    
    // MARK: 어디서 놀지?
    //타이틀
    private let whereToPlayTitle = UILabel().then {
        $0.text = "어디서 놀지?"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    //컬렉션뷰
    let whereToPlayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 76, height: 76)
        $0.minimumLineSpacing = 8}).then{
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(WhereToPlayCollectionViewCell.self, forCellWithReuseIdentifier: WhereToPlayCollectionViewCell.identifier)
        }
    
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
            $0.showsHorizontalScrollIndicator = false
            $0.register(OurMemoriesCollectionViewCell.self, forCellWithReuseIdentifier: OurMemoriesCollectionViewCell.identifier)
        }
    
    // MARK: Steady Popular Spot
    // 타이틀
    let steadyTitle = UILabel().then{
        $0.text = "Steady Popular Spot"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    //스팟 1
    //spot1 이미지
    let spot1ImageView = UIImageView().then {
        $0.image = UIImage(named: "steady_popular_spot_image1")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 11
    }
    
    //spot1 이름
    let spot1Name = UILabel().then {
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 23)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = "Gentle Monster house, \nDosan"
    }
    
    //spot1 아이콘 이미지
    let spot1Icon = UIImageView().then {
        $0.image = UIImage(named:"spot_icon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    //spot1 주소
    let spot1Address = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "강남"
    }
    
    //원 이미지
    let circle1Image = UIImageView().then {
        $0.image = UIImage(systemName: "circlebadge.fill")
        $0.tintColor = .blue4
    }
    
    //spot1 역
    let spot1Station = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "압구정로데오역 5번 출구"
    }
    
    //spot1 설명
    let spot1Description = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 15)
        $0.textColor = .icon1
        $0.numberOfLines = 0
        $0.text = "해당 공간에는 젠틀몬스터와 더불어 감각적인 아름다움\n을 지향하는 코스메틱 브랜드 '탬버린즈'와 디저트를 통\n해 새로운 판타지를 구현하는 '누데이크'가 함께 입점했\n습니다."
    }
    
    //스팟 2
    //spot2 이미지
    let spot2ImageView = UIImageView().then {
        $0.image = UIImage(named: "steady_popular_spot_image2")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 11
    }
    
    //spot2 이름
    let spot2Name = UILabel().then {
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 23)
        $0.textColor = .black
        $0.text = "RANDOM DIVERSITY"
    }
    
    //spot2 아이콘 이미지
    let spot2Icon = UIImageView().then {
        $0.image = UIImage(named:"spot_icon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    //spot2 주소
    let spot2Address = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "노들섬"
    }
    
    //원 이미지
    let circle2Image = UIImageView().then {
        $0.image = UIImage(systemName: "circlebadge.fill")
        $0.tintColor = .blue4
    }
    //spot2 역
    let spot2Station = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "노들역 2번 출구"
    }
    
    //spot2 설명
    let spot2Description = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 15)
        $0.textColor = .icon1
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.text = "'랜덤 다이버시티'는 특정 기억이나 감정을 색이나 향, 소\n리 등 또 다른 감각으로 치환하는 참여형 미디어 아트 작\n품으로 큰 인기를 얻고 있으며, 매년 각기 다른 주제를 선\n택하여 새로운 전시를 선보입니다."
    }
    
    // MARK: 컴포넌트 추가
    private func setViews(){
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-UIApplication.shared.statusBarFrame.height)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2357)
        }
        
        self.addSubview(scrollToTopButton)
        
        contentView.addSubview(bannerCollectionView)
        contentView.addSubview(logoLabel)
        contentView.addSubview(searchButton)
        contentView.addSubview(myRouteButton)
        contentView.addSubview(upcommingTitle)
        contentView.addSubview(vectorIcon)
        contentView.addSubview(upcommingButton)
        contentView.addSubview(dDayLabel)
        contentView.addSubview(circleImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(whatToPlayTitle)
        contentView.addSubview(whatToPlayCollectionView)
        contentView.addSubview(whereToPlayTitle)
        contentView.addSubview(whereToPlayCollectionView)
        contentView.addSubview(ourMemoriesTitle)
        contentView.addSubview(vectorIcon2)
        contentView.addSubview(ourMemoriesCollectionView)
        
        contentView.addSubview(steadyTitle)
        contentView.addSubview(spot1ImageView)
        contentView.addSubview(spot1Name)
        contentView.addSubview(spot1Icon)
        contentView.addSubview(spot1Address)
        contentView.addSubview(circle1Image)
        contentView.addSubview(spot1Station)
        contentView.addSubview(spot1Description)
        contentView.addSubview(spot2ImageView)
        contentView.addSubview(spot2Name)
        contentView.addSubview(spot2Icon)
        contentView.addSubview(spot2Station)
        contentView.addSubview(circle2Image)
        contentView.addSubview(spot2Address)
        contentView.addSubview(spot2Description)
        
        scrollToTopButton.snp.makeConstraints{
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-17)
            $0.right.equalToSuperview().offset(-8)
            $0.width.height.equalTo(51)
        }
        
        logoLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(62)
            $0.left.equalToSuperview().offset(24)
            
        }
        
        bannerCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
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
        
        myRouteButton.snp.makeConstraints{
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
            $0.left.equalToSuperview().inset(24)
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
            $0.right.equalToSuperview().inset(17)
            $0.width.equalTo(352)
            $0.height.equalTo(186)
        }
        
        whereToPlayTitle.snp.makeConstraints{
            $0.top.equalTo(whatToPlayCollectionView.snp.bottom).offset(44)
            $0.left.equalToSuperview().offset(24)
        }
        
        whereToPlayCollectionView.snp.makeConstraints{
            $0.top.equalTo(whereToPlayTitle.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().inset(17)
            $0.width.equalTo(352)
            $0.height.equalTo(76)
            
        }
        
        ourMemoriesTitle.snp.makeConstraints{
            $0.top.equalTo(whereToPlayCollectionView.snp.bottom).offset(44)
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
            $0.right.equalToSuperview().inset(17)
            $0.width.equalTo(352)
            $0.height.equalTo(186)
        }
        
        steadyTitle.snp.makeConstraints {
            $0.top.equalTo(ourMemoriesCollectionView.snp.bottom).offset(44)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        spot1ImageView.snp.makeConstraints {
            $0.top.equalTo(steadyTitle.snp.bottom).offset(17)
            $0.left.right.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        
        spot1Name.snp.makeConstraints {
            $0.top.equalTo(spot1ImageView.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(315)
            $0.height.equalTo(62)
        }
        spot1Icon.snp.makeConstraints {
            $0.top.equalTo(spot1Name.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        spot1Address.snp.makeConstraints {
            $0.top.equalTo(spot1Name.snp.bottom).offset(12.5)
            $0.left.equalTo(spot1Icon.snp.right).offset(6)
        }
        
        circle1Image.snp.makeConstraints{
            $0.top.equalTo(spot1Name.snp.top).offset(19.5)
            $0.left.equalTo(spot1Address.snp.right).offset(7)
            $0.width.equalTo(3)
            $0.height.equalTo(3)
        }
        
        spot1Station.snp.makeConstraints {
            $0.top.equalTo(spot1Name.snp.bottom).offset(12.5)
            $0.left.equalTo(spot1Address.snp.right).offset(13)
        }
        
        spot1Description.snp.makeConstraints {
            $0.top.equalTo(spot1Address.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().inset(33)
            $0.width.equalTo(331)
            $0.height.equalTo(72)
        }
        
        spot2ImageView.snp.makeConstraints {
            $0.top.equalTo(spot1Description.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        
        spot2Name.snp.makeConstraints {
            $0.top.equalTo(spot2ImageView.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(232)
            $0.height.equalTo(35)
        }
        spot2Icon.snp.makeConstraints {
            $0.top.equalTo(spot2Name.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(28)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        spot2Address.snp.makeConstraints {
            $0.top.equalTo(spot2Name.snp.bottom).offset(12.5)
            $0.left.equalTo(spot2Icon.snp.right).offset(6)
        }
        
        circle2Image.snp.makeConstraints{
            $0.top.equalTo(spot2Name.snp.top).offset(19.5)
            $0.left.equalTo(spot2Address.snp.right).offset(7)
            $0.width.equalTo(3)
            $0.height.equalTo(3)
        }
        
        spot2Station.snp.makeConstraints {
            $0.top.equalTo(spot2Name.snp.bottom).offset(12.5)
            $0.left.equalTo(spot2Address.snp.right).offset(13)
        }
        
        spot2Description.snp.makeConstraints {
            $0.top.equalTo(spot2Address.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().inset(33)
            $0.width.equalTo(332)
            $0.height.equalTo(76)
        }
    }
}
