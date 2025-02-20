//
//  CreateRouteViewController.swift
//  Nupi
//
//  Created by narong on 2/20/25.
//


// CreateRouteViewController.swift
import UIKit

class CreateRouteViewController: UIViewController {
    
    // `CreateRouteView`를 사용하기 위해, 보통 loadView()를 오버라이드
    override func loadView() {
        // 뷰컨트롤러의 기본 view를 CreateRouteView로 교체
        view = CreateRouteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰의 타입 캐스팅
        guard let createView = view as? CreateRouteView else { return }
        
        // 버튼 액션, 텍스트필드 델리게이트 등 이벤트 처리
        createView.addPlaceButton.addTarget(self, action: #selector(didTapAddPlace), for: .touchUpInside)
        createView.createRouteButton.addTarget(self, action: #selector(didTapCreateRoute), for: .touchUpInside)
    }
    
    @objc private func didTapAddPlace() {
        print("장소 추가 버튼 탭됨")
        // 필요하다면, (view as? CreateRouteView)?.places에 append 후 업데이트... 등등
    }
    
    @objc private func didTapCreateRoute() {
        guard let createView = view as? CreateRouteView else { return }
        
        let routeName = createView.routeNameTextField.text ?? ""
        let selectedDate = createView.datePicker.date
        
        print("경로 자동 생성 버튼 탭됨")
        print("입력된 경로 이름:", routeName)
        print("선택된 날짜:", selectedDate)
        
        // 필요한 후속 처리(네트워크 요청, 화면 이동 등)
    }
}
