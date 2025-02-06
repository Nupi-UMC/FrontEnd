//
//  UIView+Extension.swift
//  Nupi
//
//  Created by Dana Lim on 1/15/25.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
