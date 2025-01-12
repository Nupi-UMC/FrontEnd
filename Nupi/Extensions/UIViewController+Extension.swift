//
//  UIViewController+Extension.swift
//  Nupi
//
//  Created by Dana Lim on 1/12/25.
//

import UIKit

extension UIViewController {
    // MARK: 네비게이션 바 설정
        func setupNavigationBarBackgroundColor() {
            // 네비게이션 바의 배경색을 설정
            navigationController?.navigationBar.barTintColor = UIColor.bg
            navigationController?.navigationBar.layer.borderWidth = 0    // 테두리 두께 제거
            navigationController?.navigationBar.layer.borderColor = UIColor.bg.cgColor
            navigationController?.navigationBar.shadowImage = UIImage()  // 스크롤시 네비게이션 바에 그림자가 자동으로 생기기 때문에 그림자도 제거해야함

        }
        
        func setupNavigationBar(action: Selector) {
            self.navigationItem.hidesBackButton = true
            
            let backImage = UIImage(systemName: "chevron.left")
            
            let customBackButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: action)

            customBackButton.tintColor = UIColor.icon1
            customBackButton.customView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            self.navigationItem.leftBarButtonItem = customBackButton
        }
        
        @objc func customBackButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
}
