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
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
