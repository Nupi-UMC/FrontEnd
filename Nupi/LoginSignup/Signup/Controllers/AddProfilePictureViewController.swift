//
//  AddProfilePictureViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import Alamofire

class AddProfilePictureViewController: UIViewController {
    private var selectedImageURL: URL?
    
    private lazy var addProfilePictureView: AddProfilePictureView = {
        let view = AddProfilePictureView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addProfilePictureView
        
        updateStartButton(isEnabled: false)
        
        //별명 확인 입력값 변경 감지
        addProfilePictureView.nicknameTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)), for: .editingChanged)
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        addProfilePictureView.selectProfileImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        addProfilePictureView.startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
    }
    
    weak var delegate: SignUpDataDelegate? // Delegate 프로퍼티
    
    var email: String = ""
    var password: String = ""
    var verificationId : Int = 0
    
    //데이터를 모두 수집할 수 있도록, 각 뷰 컨트롤러에서 필요한 데이터를 전달받는 Delegate Protocol
    protocol SignUpDataDelegate: AnyObject {
        func didFinishSignUp(email: String, password: String, nickname: String, profileImage: UIImage?)
    }
    
    @objc private func startButtonTap(){
        
        let nickname = addProfilePictureView.nicknameTextField.text ?? ""
        let profileImage = addProfilePictureView.selectProfileImageButton.imageView?.image
        
        // Delegate를 통해 데이터 전달
        delegate?.didFinishSignUp(email: email, password: password, nickname: nickname, profileImage: profileImage)
        
        // 데이터 전송 로직 작성 (예: 백엔드 API 호출)
        registerUser()
        
        //프로필 사진, 닉네임 넘겨주기 -> 이 부분은 api 연결하면 생략 ?
        let completeSignupVC = CompleteSignUpViewController()
        completeSignupVC.receivedProfileImage = profileImage
        completeSignupVC.receivedNickName = nickname
    }
    
    @objc private func nickNameTextFieldDidChange(_ textField: UITextField) {
        validateNickNameInfo()
    }
    
    func validateNickNameInfo() {
        let nickNameText = addProfilePictureView.nicknameTextField.text ?? ""
        let isValidNickName = !nickNameText.isEmpty // 비어있지 않으면 true
        updateStartButton(isEnabled: isValidNickName)
    }
    
    //버튼 상태 업데이트
    private func updateStartButton(isEnabled: Bool) {
        addProfilePictureView.startButton.isEnabled = isEnabled
        addProfilePictureView.startButton.backgroundColor = isEnabled ? .blue3 : .grey2
        addProfilePictureView.startButton.setTitleColor(isEnabled ? .white : .icon2, for: .normal)
    }
    
    //회원가입 API
    private func registerUser() {
        let nickname = addProfilePictureView.nicknameTextField.text ?? ""
        let profileImageData = addProfilePictureView.selectProfileImageButton.imageView?.image?.jpegData(compressionQuality: 0.5)

        let url = "https://api-nupi.shop/api/signup"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "multipart/form-data"
        ]

        // JSON으로 보낼 기본 회원가입 데이터
        let parameters: [String: Any] = [
            "verificationId": verificationId,
            "email": email,
            "password": password,
            "nickname": nickname
        ]

        AF.upload(multipartFormData: { multipartFormData in
            // 1. JSON 데이터를 multipart로 변환하여 추가
            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }

            // 2. 프로필 이미지가 있으면 multipart로 추가
            if let imageData = profileImageData {
                multipartFormData.append(imageData, withName: "profileImage", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: headers)
        .validate()
        .responseDecodable(of: SignupResponse.self) { response in
            switch response.result {
            case .success(let signupResponse):
                if signupResponse.isSuccess {
                    print("회원가입 성공: \(signupResponse.message)")
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(CompleteSignUpViewController(), animated: true)
                    }
                } else {
                    print("회원가입 실패: \(signupResponse.message)")
                }
            case .failure(let error):
                print("회원가입 API 오류: \(error.localizedDescription)")
                // 서버 응답 데이터 디버깅용 출력
                            if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                                print("🚨 서버 응답 데이터: \(errorMessage)")
                            }
            }
        }
    }
}
    
extension AddProfilePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    //이미지 피커에서 이미지 선택했을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        //이미지 가져오기
        if let selectedImage = info[.originalImage] as? UIImage {
            addProfilePictureView.selectProfileImageButton.setImage(selectedImage, for: .normal)
        }
        picker.dismiss(animated: true)
    }
    
    // 이미지 선택 메서드
        @objc
        func pickImage(_ sender: Any) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
