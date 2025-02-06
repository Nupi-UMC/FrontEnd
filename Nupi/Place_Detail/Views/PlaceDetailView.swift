//
//  PlaceDetailView.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit

class PlaceDetailView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerView = PlaceDetailHeaderView()
    let placeDetailInfoView = PlaceDetailInfoView()
    
    private let dividerView : UIView = {
        let view = UIView()
        view.backgroundColor = .line1
        return view
    }()
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["상세정보", "사진", "포함된 경로", "후기"])
        control.selectedSegmentIndex = 0
        //선택된 세그멘트 배경 제거
        control.selectedSegmentTintColor = UIColor.clear
        control.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.icon1,
             NSAttributedString.Key.font: UIFont.button2],
            for: .normal
        )
        control.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.button2],
            for: .selected
        )
        //배경 이미지, 중간 칸막이 이미지 제거
        control.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        control.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return control
        
        
    }()
    
    var segmentedControlLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .blue3
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue1
        return view
    }()
    
    
    let containerView = UIView()
    
    
    private func addComponents(){
        self.addSubview(headerView)
        self.addSubview(dividerView)
        self.addSubview(lineView)
        self.addSubview(segmentedControl)
        self.addSubview(containerView)
        self.addSubview(segmentedControlLineView)
        self.addSubview(placeDetailInfoView)

        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom) // SegmentedControl 바로 아래에 위치
            make.leading.trailing.equalTo(segmentedControl) // SegmentedControl의 너비와 동일
            make.height.equalTo(1) // 1pt 높이로 설정
        }
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(457)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(11)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(46)
        }
        
        segmentedControlLineView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.width.equalTo(51)
            make.height.equalTo(1)
            make.leading.equalTo(segmentedControl.snp.leading).offset(16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func getSegmentedControl() -> UISegmentedControl {
        return segmentedControl
    }

}
