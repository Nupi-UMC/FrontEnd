//
//  CreatePasswordViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    private lazy var createPasswordView: CreatePasswordView = {
        let view = CreatePasswordView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = createPasswordView
        
        // 비밀번호 입력값 변경 감지
            createPasswordView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
            
        // 비밀번호 확인 입력값 변경 감지
        createPasswordView.confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)
            
        createPasswordView.continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
            
        // 초기 버튼 상태 비활성화
        updateContinueButton(isEnabled: false)
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        createPasswordView.continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        validatePasswordInfo()
    }

    private func validatePasswordInfo() {
        let passwordText = createPasswordView.passwordTextField.text ?? ""
        
        // 유효성 검사 결과
        let isValidPassword = isValidPasswordFormat(passwordText)
        // 에러 메시지 업데이트
        createPasswordView.passwordErrorLabel.isHidden = false
        createPasswordView.passwordErrorLabel.text = isValidPassword ? "알맞은 비밀번호입니다." : "영문, 숫자가 조합된 비밀번호를 입력해주세요"
        createPasswordView.passwordErrorLabel.textColor = isValidPassword ? .blue5 : .rice
            
        // 버튼 상태 업데이트
        updateContinueButton(isEnabled: isValidPassword && isConfirmPasswordMatched())
    }
    
    //비밀번호 확인 일치 여부 검사
    @objc private func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
        validateConfirmPassword()
    }

    private func validateConfirmPassword() {
        let isMatched = isConfirmPasswordMatched()
        
        // 에러 메시지 업데이트
        createPasswordView.confirmPasswordErrorLabel.isHidden = false
        createPasswordView.confirmPasswordErrorLabel.text = isMatched ? "비밀번호가 일치합니다" : "비밀번호가 일치하지 않습니다."
        createPasswordView.confirmPasswordErrorLabel.textColor = isMatched ? .blue5 : .rice
        
        // 버튼 상태 업데이트
        updateContinueButton(isEnabled: isMatched && isValidPasswordFormat(createPasswordView.passwordTextField.text ?? ""))
    }
    
    private func isConfirmPasswordMatched() -> Bool {
        return createPasswordView.passwordTextField.text == createPasswordView.confirmPasswordTextField.text
    }
    
    //버튼 상태 업데이트
    private func updateContinueButton(isEnabled: Bool) {
        createPasswordView.continueButton.isEnabled = isEnabled
        createPasswordView.continueButton.backgroundColor = isEnabled ? .blue3 : .grey2
        createPasswordView.continueButton.setTitleColor(isEnabled ? .white : .icon2, for: .normal)
    }
    
    @objc private func continueButtonTap(){
        let addProfilePictureVC = AddProfilePictureViewController()
        self.navigationController?.pushViewController(addProfilePictureVC, animated: true)
    }
}
