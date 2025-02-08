//
//  CompleteSignUpViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import Alamofire

class CompleteSignUpViewController: UIViewController {
    
    private lazy var completeSignUpView: CompleteSignUpView = {
        let view = CompleteSignUpView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = completeSignUpView
        completeSignUpView.moveToLoginPageButton.addTarget(self, action: #selector(moveToLoginButtonTap), for: .touchUpInside)
        completeSignUpView.exitButton.addTarget(self, action: #selector(exitButtonTap), for: .touchUpInside)
        
        self.navigationItem.hidesBackButton = true //back button 숨기기
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false //스와이프로 뒤로 가는 제스쳐 비활성화
        
        // 전달받은 프로필 사진과 닉네임 설정
        setupProfileInfo()
    }
    
    //전달받을 프로필이미지 변수
    public var receivedProfileImage: UIImage?
    //전달받을 닉네임 변수
    public var receivedNickName : String?
    
    // 프로필 정보 설정
    private func setupProfileInfo() {
        // 닉네임 표시
        completeSignUpView.userNicknameLabel.text = receivedNickName ?? "닉네임"
        
        // 프로필 이미지 설정 (없으면 기본 이미지)
        if let profileImage = receivedProfileImage {
            completeSignUpView.profilePictureView.image = profileImage
        } else {
            completeSignUpView.profilePictureView.image = UIImage(named: "defaultProfile") // 기본 프로필 이미지
        }
    }
    
    
    @objc private func moveToLoginButtonTap(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func exitButtonTap(){
        //let exitVC = ExitViewController()
        //self.navigationController?.pushViewController(exitVC,animated:true)
    }
    //기본 프로필 이미지 처리
    private func setupProfileImage() {
        let defaultImage = UIImage(named: "defaultProfile") ?? UIImage()
        completeSignUpView.profilePictureView.image = receivedProfileImage ?? defaultImage
    }

}
