//
//  CalendarMonth.swift
//  Nupi
//
//  Created by narong on 2/21/25.
//

import Foundation

struct CalendarMonth {
    let year: Int
    let month: Int
    let startDayOffset: Int
    let totalDays: Int
    let dayOfWeekNames: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    init(yyyyMM: String) {
        // "2025-02" -> ["2025", "02"]
        let comps = yyyyMM.split(separator: "-").map { String($0) }
        if comps.count == 2 {
            self.year = Int(comps[0]) ?? 2025
            self.month = Int(comps[1]) ?? 02
        } else {
            self.year = 2025
            self.month = 02
        }
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 1일 날짜
        let dateComponents = DateComponents(year: year, month: month, day: 1)
        
        // 시작 요일 offset
        if let firstDayDate = calendar.date(from: dateComponents) {
            let weekday = calendar.component(.weekday, from: firstDayDate) // 일=1, 월=2,...
            self.startDayOffset = weekday - 1 // 일요일=0
        } else {
            self.startDayOffset = 0
        }
        
        // 총 일수
        if let firstDayDate = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: firstDayDate) {
            self.totalDays = range.count
        } else {
            self.totalDays = 30
        }
    }
}
