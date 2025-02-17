//
//  RouteInfoCardView.swift
//  Nupi
//
//  Created by 선가연 on 2/15/25.
//

import UIKit

class RouteInfoCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .bg
        $0.layer.cornerRadius = 13
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
    }
    
    private let grabberView = UIView().then {
        $0.backgroundColor = .blue1
        $0.layer.cornerRadius = 50
    }
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
//        $0.register(RoutePlaceCell.self, forCellReuseIdentifier: RoutePlaceCell.identifier)
    }
    
    private func setViews() {
        addSubview(containerView)
        containerView.addSubview(grabberView)
        containerView.addSubview(tableView)
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(575)
        }
        
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(39)
            $0.height.equalTo(4)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(grabberView.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    
}
