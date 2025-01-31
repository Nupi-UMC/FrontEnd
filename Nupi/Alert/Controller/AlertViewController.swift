//
//  AlertViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/24/25.
//

import UIKit

class AlertViewController: UIViewController {
    
    private let alertView = AlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = alertView
        
        // 버튼 액션 연결
        alertView.dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        alertView.deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func dismissButtonDidTap() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func deleteButtonDidTap() {
        print("삭제 버튼 클릭")
        self.dismiss(animated: false, completion: nil)
        // 삭제 로직 추가
    }
}
