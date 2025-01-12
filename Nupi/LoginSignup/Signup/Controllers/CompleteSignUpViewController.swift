//
//  CompleteSignUpViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

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
        
        //전달받은 프로필 사진 표시
        if let profileImage = receivedProfileImage {
                completeSignUpView.profilePictureView.image = profileImage
        } else {
            completeSignUpView.profilePictureView.layer.backgroundColor = UIColor.bg.cgColor
        }
    }
    
    //전달받을 프로필이미지 변수
    public var receivedProfileImage: UIImage?
    
    
    @objc private func moveToLoginButtonTap(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func exitButtonTap(){
        //let exitVC = ExitViewController()
        //self.navigationController?.pushViewController(exitVC,animated:true)
    }
}
