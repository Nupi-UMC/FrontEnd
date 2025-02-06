//
//  MainCoordinator.swift
//  Nupi
//
//  Created by Dana Lim on 1/16/25.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }

    func showBaseViewController() {
        let tabBarController = BaseViewController()
        // SceneDelegate의 window.rootViewController를 변경하여 네비게이션 바 제거
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
    }
}
