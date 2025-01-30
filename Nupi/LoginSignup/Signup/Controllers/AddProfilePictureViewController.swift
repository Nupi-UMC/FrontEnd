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
    
    //UIImage를 base64로 인코딩
    private func encodeImageToBase64(_ image: UIImage?) -> String? {
        guard let image = image else { return nil }
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
        return imageData.base64EncodedString()
    }
    
    //회원가입 API
    private func registerUser(){
        let profileImage = addProfilePictureView.selectProfileImageButton.imageView?.image
        // UIImage -> JPEG 데이터로 변환

        guard let imageData = profileImage?.jpegData(compressionQuality: 0.8) else {
                print("이미지 변환 실패")
                return
            }
            
        let base64String = imageData.base64EncodedString()
        
        guard let imageURL = selectedImageURL else {
                print("❌ 이미지 URL이 없습니다.")
                return
            }
        
        // Encodable 구조체로 요청 데이터 생성
            let parameters = SignupRequest(
                verificationId: verificationId,
                email: email,
                password: password,
                nickname: addProfilePictureView.nicknameTextField.text!,
                profile: imageURL.absoluteString
            )
        // ✅ 🔍 디버깅: JSON 데이터가 올바르게 인코딩되었는지 확인
            do {
                let jsonData = try JSONEncoder().encode(parameters)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("📡 회원가입 요청 JSON 데이터:\n", jsonString)
                }
            } catch {
                print("🚨 JSON 인코딩 실패: \(error.localizedDescription)")
            }
        
        APIClient.postRequest(endpoint: "/api/auth/signup", parameters: parameters){ (result: Result<SignupResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess{
                    print("회원가입 성공: \(response.message)")
                    DispatchQueue.main.async {
                        // 회원가입 완료 화면으로 이동
                        let completeSignupVC = CompleteSignUpViewController()
                        self.navigationController?.pushViewController(completeSignupVC,animated: true)}
                }
                else {
                    print("회원가입 실패: \(response.message)")
                    DispatchQueue.main.async{
                    }
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
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
            
        // ✅ 1. 이미지 가져오기
                if let selectedImage = info[.originalImage] as? UIImage {
                    addProfilePictureView.selectProfileImageButton.setImage(selectedImage, for: .normal)
                }

        if let imageURL = info[.imageURL] as? URL {
                self.selectedImageURL = imageURL
                print("🖼️ 이미지 URL 저장됨: \(imageURL.absoluteString)")
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
    
