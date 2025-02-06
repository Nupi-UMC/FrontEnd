//
//  BeginSignUpViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import Alamofire

class BeginSignUpViewController: UIViewController {
    
    var email : String = ""
    //유효성검사를 위한 property
    var isValidEmail = false
    
    private lazy var beginSignUpView: BeginSignUpView = {
        let view = BeginSignUpView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = beginSignUpView
        
        //처음엔 버튼 비활성화
        updateContinueButton(isEnabled: false)
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        // 이메일 입력값 변경 감지
        beginSignUpView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        beginSignUpView.continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
    }
    
    @objc private func continueButtonTap(){
        let emailVerifyVC = VerifyEmailViewController()
        emailVerifyVC.email = self.email // 이메일 전달
        requestVerificationCodeFromServer(email: email)
        self.navigationController?.pushViewController(emailVerifyVC, animated: true)
        print("데이터 전송 = email : \(email)")
    }
    
    @objc private func emailTextFieldDidChange(_ textField : UITextField) {
        validateEmailInfo()
    }
    
    private func validateEmailInfo(){
        let emailText = beginSignUpView.emailTextField.text ?? ""
        
        //유효성 검사 결과 업데이트
        isValidEmail = isValidEmailFormat(emailText)
        // 버튼 상태 업데이트
        updateContinueButton(isEnabled: isValidEmail)
        //유효성 검사 통과시, 변수에 값 할당
        if isValidEmail {
            email = emailText
        }
        //에러 메세지 업데이트
        errorUpdateUI(for: beginSignUpView.emailTextField, errorLabel: beginSignUpView.emailErrorLabel, message: "잘못된 이메일 양식이에요.", isValid: isValidEmail)
    }
    
    //버튼 활성화하는 함수
    private func updateContinueButton(isEnabled : Bool){
        beginSignUpView.continueButton.isEnabled = isEnabled
        beginSignUpView.continueButton.backgroundColor = isEnabled ? .blue3 : .grey2 //유효하면 blue3
        beginSignUpView.continueButton.setTitleColor(isEnabled ? .white : .icon2, for: .normal) // 유효할 때 흰색
    }
    
    //서버로 이메일 전달해서 코드 요청
    private func requestVerificationCodeFromServer(email: String) {
        let parameters = EmailVerificationCodeRequest(email: email)
        
        APIClient.postRequest(endpoint: "/api/auth/requestVerification", parameters: parameters) { (result: Result<EmailVerificationCodeResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("인증 요청 보내짐: \(email)")
                    DispatchQueue.main.async {
                    }
                } else {
                    print("인증 요청 실패: \(response.message)")
                    DispatchQueue.main.async {
                        //self.handleErrorMessage(message: response.message ?? "요청에 실패했습니다.")
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    //self.handleErrorMessage(message: "네트워크 오류가 발생했습니다. 다시 시도해주세요.")
                }
            }
        }
    }
}
