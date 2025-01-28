//
//  DetailInfoViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PlaceDetailInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = placeDetailInfoView
    }
    
    private lazy var placeDetailInfoView: PlaceDetailInfoView = {
        let view = PlaceDetailInfoView()
        return view
    }()

}
