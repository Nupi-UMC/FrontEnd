////
////  RoutePlaceTableViewCell.swift
////  Nupi
////
////  Created by 선가연 on 2/15/25.
////
//
//import UIKit
//
//class RoutePlaceTableViewCell: UITableViewCell {
//    
//    static let identifier = "RoutePlaceTableViewCell"
//
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // 번호 레이블
//    private let numberLabel = UILabel().then {
//        $0.font = .heading2
//        $0.textColor = .white
//        $0.textAlignment = .center
//        $0.backgroundColor = .coffee
//        $0.layer.cornerRadius = 16.5
//        $0.clipsToBounds = true
//    }
//    
//    // 장소 이름
//    private let placeNameLabel = UILabel().then {
//        $0.font = .body3
//        $0.textColor = .blue3
//    }
//
//    // 장소 주소
//    private let placeAddressLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 13)
//        $0.textColor = .gray
//    }
//}
