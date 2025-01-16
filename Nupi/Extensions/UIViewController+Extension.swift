//
//  UIViewController+Extension.swift
//  Nupi
//
//  Created by Dana Lim on 1/12/25.
//

import UIKit

extension UIViewController {
    // MARK : 에러처리 UI 설정
    //에러처리 날때 오류 메세지 출력
    func errorUpdateUI (for textField: UITextField, errorLabel: UILabel,message:String, isValid:Bool) {
        if isValid {
            errorLabel.isHidden = true
        }
        else {
            errorLabel.text = message
            errorLabel.isHidden = false
        }
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func isValidPasswordFormat(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{1,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
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

