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
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        createPasswordView.continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
    }
    
    @objc private func continueButtonTap(){
        let addProfilePictureVC = AddProfilePictureViewController()
        self.navigationController?.pushViewController(addProfilePictureVC, animated: true)
    }
}
