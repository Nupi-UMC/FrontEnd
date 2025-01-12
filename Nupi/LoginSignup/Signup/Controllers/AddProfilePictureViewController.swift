//
//  AddProfilePictureViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class AddProfilePictureViewController: UIViewController {
    
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
    
    @objc private func startButtonTap(){
        let completeSignupVC = CompleteSignUpViewController()
        //프로필 사진 넘겨주기
        completeSignupVC.receivedProfileImage = addProfilePictureView.selectProfileImageButton.imageView?.image
        //닉네임 넘겨주기
        completeSignupVC.receivedNickName = addProfilePictureView.nicknameTextField.text
        self.navigationController?.pushViewController(completeSignupVC, animated: true)
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
    
    
}

extension AddProfilePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메서드

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    //이미지 피커에서 이미지 선택했을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            // 편집된 이미지 선택한 경우
            if let editedImage = info[.editedImage] as? UIImage {
                addProfilePictureView.selectProfileImageButton.setImage(editedImage, for: .normal)
            }
            // 원본 이미지 선택한 경우
            else if let originalImage = info[.originalImage] as? UIImage {
                addProfilePictureView.selectProfileImageButton.setImage(originalImage, for: .normal)
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
    
