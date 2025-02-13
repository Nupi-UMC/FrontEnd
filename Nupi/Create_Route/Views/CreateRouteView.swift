//
//  CreateRouteView.swift
//  Nupi
//
//  Created by Dana Lim on 2/13/25.
//

import UIKit
import SnapKit
import FSCalendar

class CreateRouteView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
        setupCustomWeekdayLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 장소 데이터
    private var images: [UIImage] = []
    
    private lazy var oneLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .heading2
        label.textColor = .white
        label.layer.backgroundColor = UIColor.blue3.cgColor
        label.layer.cornerRadius = 3.67
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading1
        label.textColor = .blue3
        
        let fullText = "경로의 이름을 입력해주세요. *"
        let attributedString = NSMutableAttributedString(string: fullText)

        // '*'만 빨간색으로 변경
        if let starRange = fullText.range(of: "*") {
            let nsRange = NSRange(starRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.rice, range: nsRange)
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예) 경로 1"
        textField.textColor = .icon2
        textField.font = .body2
        textField.layer.borderColor = UIColor.clear.cgColor
        return textField
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .icon2
        return view
    }()
    
    private lazy var twoLabel : UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = .heading2
        label.textColor = .white
        label.layer.backgroundColor = UIColor.blue3.cgColor
        label.layer.cornerRadius = 3.67
        label.textAlignment = .center
        return label
    }()
    
    private lazy var locationLabel : UILabel = {
        let label = UILabel()
        label.font = .heading1
        label.textColor = .blue3
        
        let fullText = "장소를 추가해주세요. *"
        let attributedString = NSMutableAttributedString(string: fullText)

        // '*'만 빨간색으로 변경
        if let starRange = fullText.range(of: "*") {
            let nsRange = NSRange(starRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.rice, range: nsRange)
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    // ✅ 장소 추가 CollectionView
    lazy var placeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 가로 스크롤
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoCell.identifier) // ✅ `+` 버튼 셀 등록

        return collectionView
    }()
    
    private lazy var threeLabel : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = .heading2
        label.textColor = .white
        label.layer.backgroundColor = UIColor.blue3.cgColor
        label.layer.cornerRadius = 3.67
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.font = .heading1
        label.textColor = .blue3
        label.text = "언제 가는 일정인가요?"
        return label
    }()
    
    private lazy var divideLine : UIView = {
        let view = UIView()
        view.backgroundColor = .grey1
        return view
    }()
    
    // ✅ 요일 커스텀을 위한 StackView
    private lazy var customWeekdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
            
        calendar.scope = .week
        calendar.setCurrentPage(Date(), animated: false)
        calendar.scrollEnabled = false
        
        // ✅ 오늘 기준으로 요일 정렬
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        calendar.firstWeekday = UInt(todayIndex)  // 오늘의 요일을 첫 번째 요일로 설정
        
        calendar.calendarHeaderView.removeFromSuperview()
        calendar.calendarWeekdayView.removeFromSuperview()
        calendar.headerHeight = 0  // ✅ 헤더 높이 제거
        calendar.weekdayHeight = 0
        calendar.invalidateIntrinsicContentSize()
        
        // 캘린더 스타일 설정
        calendar.appearance.selectionColor = .blue5
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .blue5
        calendar.placeholderType = .none
        calendar.appearance.titleFont = .body1
        //calendar.appearance.eventOffset = CGPoint(x: 0, y: 8)  // ✅ 날짜 아래 여백 증가
        
        calendar.clipsToBounds = false  // ✅ 캘린더가 잘리지 않도록 설정
        calendar.rowHeight = 55
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.allowsSelection = true
        calendar.appearance.borderRadius = 1.0
        
        DispatchQueue.main.async {
                calendar.layer.sublayers?.removeAll(where: { $0 is CAShapeLayer }) // ✅ 하단 구분선 제거
            }
        
        return calendar
    }()
    
    lazy var otherDateButton: UIButton = {
        var config = UIButton.Configuration.plain() // 기본 스타일 설정
        config.title = "다른 날짜 선택"
        config.baseForegroundColor = .blue3

        // 아이콘 크기 조정
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let chevronImage = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)?.withTintColor(.blue3)

        config.image = chevronImage
        config.imagePlacement = .trailing // 아이콘을 오른쪽에 배치
        config.imagePadding = 4 // 텍스트와 아이콘 사이 간격 설정

        let button = UIButton(configuration: config)
        return button
    }()
    

    lazy var randomRouteButton: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.title = "경로 자동 생성"
        
        config.baseForegroundColor = .icon2
        config.baseBackgroundColor = .grey2
        
        // 폰트 설정
        let customFont = UIFont.body3
        config.attributedTitle = AttributedString("경로 자동 생성", attributes: AttributeContainer([.font: customFont]))
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light) // 크기 & 굵기 설정
        let shuffleImage = UIImage(systemName: "shuffle", withConfiguration: symbolConfig)?.withTintColor(.icon2, renderingMode: .alwaysOriginal)
            
        config.image = shuffleImage
        config.imagePlacement = .leading
        config.imagePadding = 4
        
        let button = UIButton(configuration: config)
        
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        
        return button
    }()
    
    // 요일을 커스텀해서 표시하는 메서드
    private func setupCustomWeekdayLabels() {
        addSubview(customWeekdayStackView)
        
        customWeekdayStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(divideLine.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        var weekdays = formatter.shortWeekdaySymbols ?? ["일", "월", "화", "수", "목", "금", "토"]
        
        // 오늘을 기준으로 요일을 정렬
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        let rotatedWeekdays = Array(weekdays[todayIndex...] + weekdays[..<todayIndex])
        
        for (index, weekday) in rotatedWeekdays.enumerated() {
            let label = UILabel()
            label.text = (index == 0) ? "오늘" : weekday
            label.textColor = .icon2
            label.font = .caption1
            label.textAlignment = .center
            
            customWeekdayStackView.addArrangedSubview(label)
        }
    }

    private func addComponents(){
        addSubview(oneLabel)
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(lineView)
        addSubview(twoLabel)
        addSubview(locationLabel)
        addSubview(placeCollectionView)
        addSubview(threeLabel)
        addSubview(dateLabel)
        addSubview(calendar)
        addSubview(otherDateButton)
        addSubview(randomRouteButton)
        addSubview(divideLine)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(138)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(22)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(oneLabel.snp.centerY)
            make.leading.equalTo(oneLabel.snp.trailing).offset(8)
            make.height.equalTo(24)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(20)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(345)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleTextField.snp.bottom).offset(9)
        }
        twoLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(oneLabel.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(46)
            make.width.height.equalTo(22)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.centerY.equalTo(twoLabel.snp.centerY)
            make.height.equalTo(24)
        }
        
        placeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(344)
            make.height.equalTo(80)
        }
        
        threeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(oneLabel.snp.centerX)
            make.top.equalTo(placeCollectionView.snp.bottom).offset(46)
            make.width.height.equalTo(22)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(threeLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(24)
        }
        
        divideLine.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(336)
        }
        
        calendar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(divideLine.snp.bottom).offset(55)
            make.width.equalTo(335)
            make.height.equalTo(110)
        }
        
        otherDateButton.snp.makeConstraints { (make) in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(18)
        }
        randomRouteButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(otherDateButton.snp.bottom).offset(38)
            make.height.equalTo(40)
            make.width.equalTo(162)
        }
    }
}
