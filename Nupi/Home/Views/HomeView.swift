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
        self.setViews()
        self.setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
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

    // MARK: Upcomming Schedule
    // MARK: 뭐하고 놀지?
    // MARK: 어디서 놀지?
    // MARK: Our Memories
    // MARK: Steady Popular Spot 타이틀
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
    
    // MARK: 컴포넌트 추가
    private func setViews(){
        self.addSubview(bannerCollectionView)
        self.addSubview(logoLabel)
        self.addSubview(searchButton)
        self.addSubview(myPathButton)
        self.addSubview(steadyTitle)
        self.addSubview(steadyTableView)
        
    }
    
    private func setConstaints(){
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
        
        steadyTitle.snp.makeConstraints{
            $0.top.equalTo(searchButton.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(24)
        }
        
        steadyTableView.snp.makeConstraints{
            $0.top.equalTo(steadyTitle.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(450)
        }
    }
}
