//
//  MyRouteView.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit
import Then

class MyRouteView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    // 컨텐트 뷰
    private let contentView = UIView()
    
    // 세그먼트 컨트롤
    let segmentedControl = UISegmentedControl(items: ["생성됨", "저장됨"]).then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.icon2,
                .font: UIFont(name: "WantedSans-Medium", size: 16)
            ], for: .normal
        )
        $0.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.blue3,
                .font: UIFont(name: "WantedSans-Medium", size: 16)
            ], for: .selected
        )
    }
    
    // 선택된 세그먼트 밑줄
    private lazy var segmentUnderlineView = UIView().then {
        $0.backgroundColor = .icon2
    }
    
    // 경로 컬렉션 뷰
    let routeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 163, height: 174)
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 11
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(RouteCollectionViewCell.self, forCellWithReuseIdentifier: RouteCollectionViewCell.identifier)
    }
    
    // 세그먼트 밑줄 위치 업데이트 함수
    func updateUnderlinePosition(selectedIndex: Int) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let newXPosition = CGFloat(selectedIndex) * segmentWidth

        UIView.animate(withDuration: 0.3) {
            self.segmentUnderlineView.snp.updateConstraints {
                $0.leading.equalTo(self.segmentedControl.snp.leading).offset(newXPosition)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func setViews() {
        // 컴포넌트 추가
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(segmentUnderlineView)
        contentView.addSubview(routeCollectionView)
        
        // 레이아웃 설정
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(83)
            $0.height.equalTo(43)
        }
        
        segmentUnderlineView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.height.equalTo(1.5)
            $0.width.equalTo(segmentedControl.frame.width)
            $0.leading.equalTo(segmentedControl.snp.leading)
        }
        
        routeCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmentUnderlineView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(500)
            $0.bottom.equalToSuperview()
        }
    }
}
