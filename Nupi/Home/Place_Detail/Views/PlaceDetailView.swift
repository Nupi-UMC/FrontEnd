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
        self.backgroundColor = .line1
        
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerView = PlaceDetailHeaderView()
    
    private let segmentedControl : UISegmentedControl = {
        let control = UISegmentedControl(items: ["상세정보", "사진", "포함된 경로", "후기"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .bg
        control.selectedSegmentTintColor = .bg
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.icon1], for: .normal)
        return control
    }()
    
    let containerView = UIView()
    
    
    private func addComponents(){
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(457)
        }
        
        self.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        self.addSubview(containerView)
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
