//
//  ViewController.swift
//  Nupi
//
//  Created by 신연주 on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
    }
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
}
