//
//  LoginAlertView.swift
//  Nupi
//
//  Created by 신연주 on 2/20/25.
//

import UIKit

class LoginAlertView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //
    private let loginAlertView = UIView().then {
        $0.backgroundColor = .bg
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    // 제목 레이블
    let titleLabel = UILabel().then {
        $0.text = "로그인 하시겠습니까?"
        $0.textColor = .blue3
        $0.font = .body3
    }
    
    let subtitleLabel = UILabel().then {
        $0.text = "로그인이 필요한 서비스입니다."
        $0.textColor = .icon2
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
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.blue5, for: .normal)
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
        addSubview(loginAlertView)
        loginAlertView.addSubview(titleLabel)
        loginAlertView.addSubview(subtitleLabel)
        loginAlertView.addSubview(divider1)
        loginAlertView.addSubview(buttonStackView)
        loginAlertView.addSubview(divider2)

        buttonStackView.addArrangedSubview(dismissButton)
        buttonStackView.addArrangedSubview(loginButton)

        loginAlertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(80)
            $0.height.equalTo(167)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(39)
        }
        
        subtitleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).inset(8)
            $0.bottom.equalTo(buttonStackView.snp.top)
        }

        divider1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(0.5)
            $0.horizontalEdges.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(49)
        }

        divider2.snp.makeConstraints {
            $0.width.equalTo(0.5)
            $0.height.equalTo(buttonStackView.snp.height)
            $0.center.equalTo(buttonStackView)
        }
    }

}
