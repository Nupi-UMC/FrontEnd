//
//  AlertView.swift
//  Nupi
//
//  Created by 선가연 on 1/24/25.
//

import UIKit

class AlertView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private let alertView = UIView().then {
        $0.backgroundColor = .bg
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    // 제목 레이블
    let titleLabel = UILabel().then {
        $0.text = "전체 항목을 삭제합니다."
        $0.textColor = .text1
        $0.font = .body3
    }
    
    // 버튼 스택 뷰
    private let buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    // 취소 버튼
    let dismissButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor.icon1, for: .normal)
        $0.titleLabel?.font = .tabbar1
    }
    
    // 삭제 버튼
    let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(UIColor.rice, for: .normal)
        $0.titleLabel?.font = .tabbar1
    }
    
    // 버튼 구분자
    let divider1 = UIView().then {
        $0.backgroundColor = .icon2
    }
    
    let divider2 = UIView().then {
        $0.backgroundColor = .icon2
    }
    
    private func setViews() {
        addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(divider1)
        alertView.addSubview(buttonStackView)
        alertView.addSubview(divider2)

        buttonStackView.addArrangedSubview(dismissButton)
        buttonStackView.addArrangedSubview(deleteButton)
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(80)
            $0.height.equalTo(130)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top)
        }
        
        divider1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(0.5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        divider2.snp.makeConstraints {
            $0.width.equalTo(0.5)
            $0.height.equalTo(buttonStackView.snp.height)
            $0.center.equalTo(buttonStackView)
        }
    }
}
