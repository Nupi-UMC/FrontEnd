//
//  IncludedRoutesViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/19/25.
//

import UIKit

class IncludedRoutesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        self.view = includedRoutesView
    }
    
    private lazy var includedRoutesView: IncludedRoutesView = {
        let view = IncludedRoutesView()
        return view
    }()

}
