//
//  CalendarDayCell.swift
//  Nupi
//
//  Created by narong on 2/21/25.
//
import UIKit
import Then

class CalendarDayCell: UICollectionViewCell {
    static let reuseIdentifier = "CalendarDayCell"
    
    /// 날짜를 표시하는 라벨
    private let dayLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .label
    }
    
    /// 선택된 날짜를 표시할 파란색 원형 배경
    private let highlightView = UIView().then {
        $0.backgroundColor = .systemBlue
        $0.isHidden = true  // 기본적으로 숨김
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(highlightView)
        contentView.addSubview(dayLabel)
        
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // highlightView를 셀의 중앙에 원형으로 배치
            highlightView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            highlightView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            highlightView.widthAnchor.constraint(equalToConstant: 36),
            highlightView.heightAnchor.constraint(equalToConstant: 36),
            
            // dayLabel도 중앙 정렬
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // 원형 모양을 위해 cornerRadius 설정
        highlightView.layer.cornerRadius = 18
        highlightView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 셀 구성 함수
    /// - Parameters:
    ///   - day: 해당 셀에 표시할 '일' (없으면 빈칸)
    ///   - isToday: 오늘 날짜인지 여부
    ///   - isSelectedDate: 사용자가 탭(선택)한 날짜인지 여부
    func configure(day: Int?, isToday: Bool, isSelectedDate: Bool) {
        // 날짜가 없는 칸(이전달/다음달 영역)이면 빈칸 처리
        guard let day = day else {
            dayLabel.text = ""
            highlightView.isHidden = true
            contentView.backgroundColor = .clear
            return
        }
        
        dayLabel.text = "\(day)"
        
        // 우선순위: 선택된 날짜 -> 원형 파란 배경 + 흰색 글자
        if isSelectedDate {
            highlightView.isHidden = false
            dayLabel.textColor = .white
        } else {
            // 선택되지 않은 경우 -> highlightView 숨김
            highlightView.isHidden = true
            
            // 오늘 날짜면 파란색 글씨, 아니면 기본(.label or .black)
            dayLabel.textColor = isToday ? .systemBlue : .label
        }
    }
}
