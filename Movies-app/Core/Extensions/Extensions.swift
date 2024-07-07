//
//  Extensions.swift
//  Movies-app
//
//  Created by Tatarella on 06.07.24.
//

import Foundation
import UIKit

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIImageView {
    func load(from url: URL, with loader: UIActivityIndicatorView) {
        loader.startAnimating()
        DispatchQueue.global().async { [weak self] in
            defer {
                DispatchQueue.main.async {
                    loader.stopAnimating()
                }
            }
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if self?.window != nil {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
