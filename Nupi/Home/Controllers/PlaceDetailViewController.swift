//
//  PlaceDetailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/18/25.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = placeDetailView
    }
    
    private lazy var placeDetailView: PlaceDetailView = {
        let view = PlaceDetailView()
        return view
    }()
    
    
}
