//
//  VerifyEmailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import Alamofire

class VerifyEmailViewController: UIViewController {
    
    private lazy var verifyEmailView: VerifyEmailView = {
        let view = VerifyEmailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = verifyEmailView
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        verifyEmailView.emailVerifyButton.addTarget(self, action: #selector(verifyEmailButtonTap), for: .touchUpInside)
        verifyEmailView.resendVerificationCodeButton.addTarget(self, action: #selector(resendVerificationCodeButtonTap), for: .touchUpInside)
        
        // 인증번호 입력값 변경 감지
        verifyEmailView.verificationCodeTextField.addTarget(self, action: #selector(verificationCodeTextFieldDidChange(_:)), for: .editingChanged)
        
        // 화면이 로드될 때 toastPopup, timer 표시
        showToastPopup()
        startTimer()
    }
    
    var email: String?
    
    private var timer: Timer?
    private var limitTime: Int = 300 // 초기 5분
    
    @objc private func verifyEmailButtonTap(){
        guard let email = self.email, !email.isEmpty else {
                print("이메일이 입력되지 않았습니다.")
                return
            }
        //API 호출
        checkVerificationCodeFromServer(email: email, verificationCode: verifyEmailView.verificationCodeTextField.text!)
    }
    
    
    // 인증번호 형식 검증 함수 (숫자 6자리 여부 확인)
    private func validateVerificationCodeFormat(_ code: String) -> Bool {
        let codeRegex = "^[0-9]{6}$" // 6자리 숫자 정규식
        let predicate = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        return predicate.evaluate(with: code)
    }
    
    //서버에서 인증코드 확인
    private func checkVerificationCodeFromServer(email: String, verificationCode: String) {
        guard validateVerificationCodeFormat(verificationCode) else {
                print("올바른 인증번호를 입력해주세요.")
                return
            }

        let parameters = EmailVerificationCodeConfirmRequest(email: email, verificationCode: verificationCode)
        
        // 디버깅용 JSON 출력
        if let jsonData = try? JSONEncoder().encode(parameters),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("Request Body: \(jsonString)")
        }

        // API 요청
        APIClient.postRequest(endpoint: "/api/auth/verifyCode", parameters: parameters) {
            (result: Result<EmailVerificationCodeConfirmResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("인증 성공")
                    if let verificationId = response.result?.verificationId {
                        print("verificationId: \(verificationId)") // 디버깅용
                        DispatchQueue.main.async {
                            let createPasswordVC = CreatePasswordViewController()
                            createPasswordVC.email = email
                            createPasswordVC.verificationId = verificationId
                            self.navigationController?.pushViewController(createPasswordVC, animated: true)
                        }
                    }
                        
                } else {
                    print("인증 요청 실패: \(response.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func resendVerificationCodeButtonTap() {
        guard let email = self.email, !email.isEmpty else {
            print("이메일이 입력되지 않았습니다.")
            return }
        requestVerificationCodeFromServer(email: email)
        print("인증번호 재발송")
        // 토스트 메시지 표시
        showToastPopup()
        resetTimer()
    }
    
    //서버로 코드 요청
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
                        self.errorUpdateUI(for: self.verifyEmailView.verificationCodeTextField, errorLabel: self.verifyEmailView.codeErrorLabel, message: response.message, isValid: false)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorUpdateUI(for: self.verifyEmailView.verificationCodeTextField, errorLabel: self.verifyEmailView.codeErrorLabel, message: "서버 오류가 발생했습니다. 다시 시도해주세요.", isValid: false)
                }
            }
        }
    }
    
    //textfield에 값 들어오는지 확인하는 함수
    @objc private func verificationCodeTextFieldDidChange(_ textField: UITextField) {
        validateCodeInfo()
    }
    
    //인증번호 일치하는지 확인하는 함수
    @objc private func validateCodeInfo(){
        let codeText = verifyEmailView.verificationCodeTextField.text ?? ""
        let isValidCode = validateVerificationCodeFormat(codeText) // 인증번호 형식 검증
        updateEmailVerifyButton(isEnabled: isValidCode)
        errorUpdateUI(for: verifyEmailView.verificationCodeTextField, errorLabel: verifyEmailView.codeErrorLabel, message: "인증번호를 확인해주세요.", isValid: isValidCode)
    }
    
    //이메일 인증하기 버튼 상태 업데이트
    private func updateEmailVerifyButton(isEnabled: Bool) {
        verifyEmailView.emailVerifyButton.isEnabled = isEnabled
        verifyEmailView.emailVerifyButton.backgroundColor = isEnabled ? .blue3 : .grey2
        verifyEmailView.emailVerifyButton.setTitleColor(isEnabled ? .white : .icon2, for: .normal)
    }
    
    
    // 토스트 팝업 표시 함수
    private func showToastPopup() {
        verifyEmailView.toastPopup.isHidden = false
        verifyEmailView.toastPopup.alpha = 0
        
        // 0.3초 동안 페이드 인 애니메이션
        UIView.animate(withDuration: 0.3, animations: {
            self.verifyEmailView.toastPopup.alpha = 1
        }) { _ in
            // 3초 후에 페이드 아웃 애니메이션과 함께 사라지게 설정
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.verifyEmailView.toastPopup.alpha = 0
                }) { _ in
                    self.verifyEmailView.toastPopup.isHidden = true
                    }
                }
            }
        }
    
    // 타이머 시작
        private func startTimer() {
            limitTime = 300 // 5분 초기화
            verifyEmailView.timerLabel.isHidden = false
            verifyEmailView.timerButton.isHidden = false
            updateTimerLabel()
            
            timer?.invalidate() // 기존 타이머가 있으면 무효화
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
        // 타이머 리셋
        private func resetTimer() {
            timer?.invalidate()
            limitTime = 300 // 5분으로 리셋
            startTimer()
        }
        
        @objc private func updateTimer() {
            if limitTime > 0 {
                limitTime -= 1
                updateTimerLabel()
            } else {
                timer?.invalidate()
                verifyEmailView.timerLabel.isHidden = true
                verifyEmailView.timerButton.isHidden = true
            }
        }
        
        private func updateTimerLabel() {
            let minute = (limitTime % 3600) / 60
            let second = (limitTime % 3600) % 60
            verifyEmailView.timerLabel.text = String(format: "%02d:%02d", minute, second)
            
            // 남은 시간이 1분 이하일 경우 텍스트 색상 변경
            verifyEmailView.timerLabel.textColor = limitTime <= 59 ? .red : .blue5
            verifyEmailView.timerButton.tintColor = limitTime <= 59 ? .red : .blue5
        }
}
