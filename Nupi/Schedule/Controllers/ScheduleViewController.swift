//
//  ViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/4/25.
//
import UIKit
import Alamofire
import Then

class ScheduleViewController: UIViewController {
    
    // "yyyy-MM" 형태로 지정한 달 (예: "2025-02")
    private let monthString: String
    
    // 달력 계산 모델
    private var calendarMonth: CalendarMonth?
    
    // 오늘 날짜(년, 월, 일)
    private var currentYear: Int = 0
    private var currentMonthValue: Int = 0
    private var currentDay: Int = 0
    
    // 사용자 선택된 날짜
    private var selectedDay: Int?
    
    // 최대 42칸 (7열 x 6행)
    private let totalCells = 42
    
    // 달력 표시용 UICollectionView
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .white
        $0.dataSource = self
        $0.delegate = self
        $0.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.reuseIdentifier)
    }
    
    // MARK: - Init
    
    init(monthString: String) {
        self.monthString = monthString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        fallbackToDummyCalendar()
        
        setupCollectionViewLayout()
        
        // 서버 통신 시도
        fetchCalendarData()
    }
    
    // MARK: - 더미 설정
    private func fallbackToDummyCalendar() {
        self.calendarMonth = CalendarMonth(yyyyMM: "2025-02")
        
        self.currentYear = 2025
        self.currentMonthValue = 2
        self.currentDay = 21
        
        // 혹시 이미 컬렉션뷰가 있을 경우 즉시 리로드
        self.collectionView.reloadData()
    }
    
    // MARK: - 네트워크 통신
    private func fetchCalendarData() {
        APIClient.fetchCalendarRoutes(month: monthString) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // 응답 파싱
                guard let calendarResult = response.result else {
                    print("응답")
                    return
                }
                
                self.calendarMonth = CalendarMonth(yyyyMM: calendarResult.month)
                
                let now = Date()
                let comps = Calendar.current.dateComponents([.year, .month, .day], from: now)
                self.currentYear = comps.year ?? 2025
                self.currentMonthValue = comps.month ?? 2
                self.currentDay = comps.day ?? 21
                
                
                // UI 업데이트
                self.collectionView.reloadData()
                
            case .failure(let error):
                print("API 호출 데이터 유지: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Layout
    private func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension ScheduleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCells
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDayCell.reuseIdentifier,
            for: indexPath
        ) as? CalendarDayCell,
        let calendarMonth = calendarMonth else {
            return UICollectionViewCell()
        }
        
        let offset = calendarMonth.startDayOffset
        let totalDays = calendarMonth.totalDays
        
        // 이전/다음 달 영역은 비워둠
        if indexPath.item < offset || indexPath.item >= offset + totalDays {
            cell.configure(day: nil, isToday: false, isSelectedDate: false)
        } else {
            let dayNumber = indexPath.item - offset + 1
            
            // 오늘 날짜인지 판별
            let isToday = (calendarMonth.year == currentYear &&
                           calendarMonth.month == currentMonthValue &&
                           dayNumber == currentDay)
            
            // 사용자가 탭한 날짜인지 판별
            let isSelectedDate = (dayNumber == selectedDay)
            
            cell.configure(day: dayNumber, isToday: isToday, isSelectedDate: isSelectedDate)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    
    // 7열 x 6행
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7
        let height = collectionView.bounds.height / 6
        return CGSize(width: width, height: height)
    }
    
    // 셀 선택 시 (날짜 탭)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let calendarMonth = calendarMonth else { return }
        
        let offset = calendarMonth.startDayOffset
        let totalDays = calendarMonth.totalDays
        
        if indexPath.item >= offset && indexPath.item < offset + totalDays {
            let dayNumber = indexPath.item - offset + 1
            selectedDay = dayNumber
            
            print("선택된 날짜: \(calendarMonth.year)-\(calendarMonth.month)-\(dayNumber)")
            collectionView.reloadData()
        }
    }
}
