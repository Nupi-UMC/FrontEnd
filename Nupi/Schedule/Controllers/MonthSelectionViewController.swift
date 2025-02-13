//
//  MonthSelectionViewController.swift
//  Nupi
//
//  Created by Dana Lim on 2/13/25.
//

import UIKit

protocol MonthSelectionDelegate: AnyObject {
    func didSelectMonth(year: Int, month: Int)
}

class MonthSelectionViewController: UIViewController {
    
    weak var delegate: MonthSelectionDelegate?
    private let monthSelectionView = MonthSelectionView()
    private var year: Int = Calendar.current.component(.year, from: Date()) // 현재 연도 저장
    private var selectedMonth: Int? = nil  // 선택된 달 저장


    override func loadView() {
        self.view = monthSelectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 연도 설정
        updateYearLabel()

        // 닫기 버튼 액션 추가
        monthSelectionView.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)

        // 연도 변경 버튼 액션 추가
        monthSelectionView.prevYearButton.addTarget(self, action: #selector(decreaseYear), for: .touchUpInside)
        monthSelectionView.nextYearButton.addTarget(self, action: #selector(increaseYear), for: .touchUpInside)

        // 월 버튼 클릭 이벤트 추가 (배열 활용)
        for button in monthSelectionView.monthButtons {
            button.addTarget(self, action: #selector(monthButtonTapped(_:)), for: .touchUpInside)
        }
    }

    // 연도 업데이트
    private func updateYearLabel() {
        monthSelectionView.titleLabel.text = "\(year)년"
    }

    // 연도 감소
    @objc private func decreaseYear() {
        year -= 1
        updateYearLabel()
    }

    // 연도 증가
    @objc private func increaseYear() {
        year += 1
        updateYearLabel()
    }

    // 모달 닫기
    @objc private func closeModal() {
        dismiss(animated: true)
    }

    // 월 버튼 클릭 시 스타일 변경
    @objc private func monthButtonTapped(_ sender: UIButton) {
        // 기존 선택된 버튼 스타일 원래대로 되돌리기
        if let previousMonth = selectedMonth {
            let previousButton = monthSelectionView.monthButtons.first { $0.tag == previousMonth }
            previousButton?.backgroundColor = .clear
            previousButton?.setTitleColor(.blue3, for: .normal)
            previousButton?.layer.borderWidth = 0
        }

        // 새롭게 선택된 버튼 스타일 변경 (45x45 원형 배경 적용)
        sender.backgroundColor = UIColor.blue1  // 연한 파란색 원형 배경
        sender.setTitleColor(.black, for: .normal)  // 글씨 색상을 검정색으로 변경
        sender.layer.cornerRadius = 22.5
        sender.layer.borderWidth = 0
        sender.clipsToBounds = true

        // 선택된 달 업데이트
        selectedMonth = sender.tag

        // 선택된 월을 ScheduleViewController로 전달
        delegate?.didSelectMonth(year: year, month: sender.tag)
        dismiss(animated: true)
    }
}
