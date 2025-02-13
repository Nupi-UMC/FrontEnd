//
//  MonthSelectionView.swift
//  Nupi
//
//  Created by Dana Lim on 2/13/25.
//

import UIKit
import SnapKit

class MonthSelectionView: UIView {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let closeButton = UIButton()
    let prevYearButton = UIButton() // "<" 버튼
    let nextYearButton = UIButton() // ">" 버튼
    let gridStackView = UIStackView()
    var monthButtons: [UIButton] = []  // 월 버튼 배열 추가

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .bg // 반투명 배경
        
        setupContainerView()
        setupYearControls()
        setupCloseButton()
        setupMonthButtons()
    }

    private func setupContainerView() {
        containerView.backgroundColor = .bg
        containerView.layer.cornerRadius = 12
        addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupYearControls() {
        prevYearButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        prevYearButton.tintColor = .icon2
        
        titleLabel.text = "2025년"
        titleLabel.textAlignment = .center
        titleLabel.font = .heading1
        titleLabel.textColor = .icon1
        
        nextYearButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextYearButton.tintColor = .icon2

        addSubview(prevYearButton)
        addSubview(titleLabel)
        addSubview(nextYearButton)

        prevYearButton.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(118)
            make.width.height.equalTo(20)
            make.centerY.equalTo(titleLabel)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(60)
            make.height.equalTo(24)
            make.centerX.equalTo(containerView)
        }

        nextYearButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView).offset(-118)
            make.width.height.equalTo(20)
            make.centerY.equalTo(titleLabel)
        }
    }

    private func setupCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .icon2
        
        containerView.addSubview(closeButton)

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(24)
            make.trailing.equalTo(containerView).inset(20)
            make.height.width.equalTo(17)
        }
    }

    private func setupMonthButtons() {
        gridStackView.axis = .vertical
        gridStackView.spacing = 10
        gridStackView.alignment = .center  // 버튼이 전체 너비를 차지하도록 변경
        gridStackView.distribution = .equalSpacing  // 버튼 크기를 균등하게 확장
        containerView.addSubview(gridStackView)

        gridStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(51)  // 좌우 여백 설정
            make.bottom.equalTo(containerView).offset(-92)
        }

        let months = Array(1...12)
        let buttonsPerRow = 4  // 4열로 설정

        for i in stride(from: 0, to: months.count, by: buttonsPerRow) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 35
            rowStackView.distribution = .equalSpacing  // ✅ 버튼 크기 균등 분배

            for j in i..<min(i + buttonsPerRow, months.count) {
                let monthButton = UIButton()
                monthButton.setTitle("\(months[j])월", for: .normal)
                monthButton.setTitleColor(.blue3, for: .normal)
                monthButton.titleLabel?.font = .body1
                monthButton.backgroundColor = .clear  // ✅ 초기 배경색 없음
                monthButton.layer.cornerRadius = 22.5  // ✅ 원형 적용
                monthButton.clipsToBounds = true
                monthButton.layer.borderWidth = 0
                monthButton.tag = months[j]
                
                monthButtons.append(monthButton)  // 배열에 버튼 추가
                rowStackView.addArrangedSubview(monthButton)
                
                monthButton.snp.makeConstraints { make in
                    make.width.height.equalTo(45)  // ✅ 크기 45x45 고정
                }
            }
            
            

            gridStackView.addArrangedSubview(rowStackView)
        }
    }
}
