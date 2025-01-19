//
//  DetailInfoViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class DetailInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = detailInfoView
    }
    
    private lazy var detailInfoView: DetailInfoView = {
        let view = DetailInfoView()
        return view
    }()

}
