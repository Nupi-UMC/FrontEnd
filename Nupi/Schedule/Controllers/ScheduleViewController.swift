//
//  ViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/4/25.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    private let scheduleView = ScheduleView()
    
    // ✅ 더미 일정 데이터 (날짜별 일정)
        private let events: [String: Schedule] = [
            "2025-02-13": Schedule(
                image: "event1",
                title: "문래로 소품샵 털러감",
                subtitle: "소품샵 투어 - Drake",
                location: "Dana Lim",
                category: "소품샵 투어",
                participants: ["Drake", "Lisa"]
            ),
            "2024-12-26": Schedule(
                image: "event2",
                title: "연말 모임",
                subtitle: "친구들과 연말 파티",
                location: "Mark",
                category: "모임",
                participants: ["Chris", "Emma", "Sophie"]
            )
        ]

    override func loadView() {
        self.view = scheduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleView.calendar.delegate = self
        scheduleView.calendar.dataSource = self
        scheduleView.menuButton.addTarget(self, action: #selector(openMonthSelection), for: .touchUpInside)
        
        // 초기에 월 이름 업데이트
        updateHeaderTitle()
    }

    // ✅ 햄버거 버튼 클릭 시 달 선택 모달 띄우기
    @objc private func openMonthSelection() {
        let monthSelectionVC = MonthSelectionViewController()
        
        if let sheet = monthSelectionVC.sheetPresentationController {
            sheet.detents = [.custom { _ in return 350 }]   // ✅ 중간 크기, 큰 크기 설정 가능
        }
        monthSelectionVC.delegate = self
        present(monthSelectionVC, animated: true)
    }

    // 현재 월을 "Feb 2025"처럼 영어로 표시
    private func updateHeaderTitle() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")  // ✅ 월을 영어로 표시
        formatter.dateFormat = "MMM yyyy"  // Feb 2025 형식

        scheduleView.headerLabel.text = formatter.string(from: scheduleView.calendar.currentPage)
    }

    // 달이 변경될 때 헤더 업데이트
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateHeaderTitle()
    }
    
    // 날짜 아래 동그라미(이벤트) 개수 설정
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        return events.keys.contains(dateString) ? 1 : 0  // 일정이 있는 날짜는 동그라미 1개 표시
    }

    // 날짜 선택 시 일정 표시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: date)  // 선택한 날짜를 문자열로 변환
        
        if let event = events[selectedDate] {
            // 일정이 있을 경우 `ScheduleCell` 업데이트
            scheduleView.scheduleCell.configure(with: event)
            scheduleView.eventView.isHidden = false
        } else {
            // 일정이 없을 경우 숨김
            scheduleView.eventView.isHidden = true
        }
    }
}

// MonthSelectionViewController에서 선택한 연도와 월을 처리하는 프로토콜 구현
extension ScheduleViewController: MonthSelectionDelegate {
    func didSelectMonth(year: Int, month: Int) {
        if let newDate = Calendar.current.date(from: DateComponents(year: year, month: month)) {
            scheduleView.calendar.setCurrentPage(newDate, animated: true)
            updateHeaderTitle()  // 선택한 후 헤더 업데이트
        }
    }
}
