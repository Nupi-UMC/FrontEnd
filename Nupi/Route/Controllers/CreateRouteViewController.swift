//
//  CreateRouteViewController.swift
//  Nupi
//
//  Created by narong on 2/20/25.
//


// CreateRouteViewController.swift
import UIKit

class CreateRouteViewController: UIViewController {
    
    override func loadView() {
        view = CreateRouteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰의 타입 캐스팅
        guard let createView = view as? CreateRouteView else { return }
        
        createView.addPlaceButton.addTarget(self, action: #selector(didTapAddPlace), for: .touchUpInside)
        createView.createRouteButton.addTarget(self, action: #selector(didTapCreateRoute), for: .touchUpInside)
    }
    
    @objc private func didTapAddPlace() {
        print("장소 추가 버튼 탭됨")
        
    }
    
    @objc private func didTapCreateRoute() {
        guard let createView = view as? CreateRouteView else { return }
        
        let routeName = createView.routeNameTextField.text ?? ""
        let selectedDate = createView.datePicker.date
        
        print("경로 자동 생성 버튼 탭됨")
        print("입력된 경로 이름:", routeName)
        print("선택된 날짜:", selectedDate)
    }
}
