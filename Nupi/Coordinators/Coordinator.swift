//
//  Coordinator.swift
//  Nupi
//
//  Created by Dana Lim on 1/16/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
