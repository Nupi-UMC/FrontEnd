//
//  PhotosViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = photosView
    }
    
    private lazy var photosView: PhotosView = {
        let view = PhotosView()
        return view
    }()
}
