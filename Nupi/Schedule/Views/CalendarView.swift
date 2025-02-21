//
//  CalendarView.swift
//  Nupi
//
//  Created by narong on 2/21/25.
//
import UIKit
import Then

class CalendarView: UIView {
    
    // 상단에 월 표시
    let monthLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .darkGray
    }
    
    // 요일 표시 스택뷰
    private let dayOfWeekStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 0
    }
    
    // 날짜 표시용 컬렉션뷰
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
    }
    
    // 하단 버튼
    let addButton = UIButton(type: .system).then {
        $0.setTitle("일정에 경로 추가", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        addSubview(monthLabel)
        addSubview(dayOfWeekStackView)
        addSubview(collectionView)
        addSubview(addButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 요일 스택뷰에 요일 라벨들 추가
    func configureDayOfWeekLabels(_ dayNames: [String]) {
        dayOfWeekStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for name in dayNames {
            let label = UILabel().then {
                $0.text = name
                $0.textAlignment = .center
                $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                $0.textColor = .gray
            }
            dayOfWeekStackView.addArrangedSubview(label)
        }
    }
    
    private func setupLayout() {
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            dayOfWeekStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 12),
            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekStackView.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: dayOfWeekStackView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 160),
            
            collectionView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),
        ])
    }
}
