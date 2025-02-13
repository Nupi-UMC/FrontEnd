//
//  ScheduleView.swift
//  Nupi
//
//  Created by Dana Lim on 1/9/25.
//

import UIKit
import SnapKit
import FSCalendar

class ScheduleView: UIView {
    
    let calendar = FSCalendar()
    let menuButton = UIButton()   // 햄버거 버튼 
    let headerLabel = UILabel()  // 커스텀 헤더
    
    // 일정 뷰 (ScheduleCell을 포함할 컨테이너)
    let eventView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue6
        view.isHidden = true
        return view
    }()
    //일정 카드 (ScheduleCell을 직접 사용)
    let scheduleCell = ScheduleCell()
    
    let addRouteButton: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.title = "일정에 경로 추가"
        
        config.baseForegroundColor = .line1
        config.baseBackgroundColor = .icon1
        
        // 폰트 설정
        let customFont = UIFont.body3
        config.attributedTitle = AttributedString("일정에 경로 추가", attributes: AttributeContainer([.font: customFont]))
        
        config.image = UIImage(named: "addRoute")
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        let button = UIButton(configuration: config)
        
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.25
        button.layer.borderColor = UIColor.bg.cgColor
        button.clipsToBounds = true
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .bg
        
        addSubview(addRouteButton)
        addRouteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(665)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(173)
        }

        setupMenuButton()
        setupHeaderLabel()
        setupCalendar()
        setupEventView()
    }
    
    // `eventView`가 보이면 버튼 숨기기 / 없으면 버튼 다시 보이기
    func updateEventViewVisibility(isEventVisible: Bool) {
        eventView.isHidden = !isEventVisible
        addRouteButton.isHidden = isEventVisible
    }

    // 햄버거 버튼 UI 설정 (UIButton 사용)
    private func setupMenuButton() {
        menuButton.setImage(UIImage(named: "hamburger"), for: .normal)  // "hamburger" 이미지 사용
        menuButton.imageView?.contentMode = .scaleAspectFit  // 이미지 비율 유지

        addSubview(menuButton)

        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73.5)
            make.leading.equalToSuperview().offset(145)
            make.width.height.equalTo(15)
        }
    }

    // 커스텀 헤더 추가 (월 이름을 영어로 표시)
    private func setupHeaderLabel() {
        headerLabel.textAlignment = .center
        headerLabel.font = .heading2
        headerLabel.textColor = .icon1
        addSubview(headerLabel)

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(menuButton) // ✅ 햄버거 버튼과 같은 높이 유지
            make.leading.equalTo(menuButton.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
    }

    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .grey1
        return view
    }()
    
    // FSCalendar UI 설정
    private func setupCalendar() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        // 요일(Weekday) 폰트 변경
        calendar.appearance.weekdayFont = .caption1
        calendar.appearance.weekdayTextColor = .icon1

        // 날짜(Date) 폰트 변경
        calendar.appearance.titleFont = .body1


        // 선택된 날짜: 파란색 동그라미, 글씨 흰색
        calendar.appearance.selectionColor = .blue5
        calendar.appearance.titleSelectionColor = .white

        // 오늘 날짜: 배경 없음, 글씨 파란색
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .blue5

        // 요일을 "월화수목금토일"로 설정
        calendar.locale = Locale(identifier: "ko_KR")

        // 기본 FSCalendar 헤더 숨기기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.calendarHeaderView.isHidden = true

        // 전·후 달의 날짜 숨기기 (현재 월의 날짜만 표시)
        calendar.placeholderType = .none
        
        // 일정 있는 날짜 아래 동그라미 색상 설정
        calendar.appearance.eventDefaultColor = .blue1
        calendar.appearance.eventSelectionColor = .blue1  // 선택된 날짜에도 동그라미 유지
        calendar.appearance.eventOffset = CGPoint(x: 0, y: 7) //  날짜 아래로 8포인트 이동

        addSubview(calendar)
        addSubview(separatorLine)

        calendar.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(400)
        }
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(calendar.calendarWeekdayView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(1)
        }
    }
    //`eventView` 안에 `ScheduleCell` 추가
    private func setupEventView() {
        addSubview(eventView)
        eventView.addSubview(scheduleCell)
        
        eventView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(191)
        }
        scheduleCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
