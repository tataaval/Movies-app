//
//  Typography.swift
//  Movies-app
//
//  Created by Tatarella on 05.07.24.
//

import UIKit
import Foundation

struct Typography {
    static let heading1: UIFont = .poppinsMedium(size: 34)
    static let heading2: UIFont = .poppinsSemibold(size: 18)
    static let heading3: UIFont = .poppinsSemibold(size: 16)
    static let heading4: UIFont = .poppinsRegular(size: 16)
    static let heading5: UIFont = .poppinsSemibold(size: 14)
    static let body: UIFont = .poppinsRegular(size: 12)
    
}

extension UIFont {
    static func poppinsMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    static func poppinsSemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Semibold", size: size) ?? .systemFont(ofSize: size)
    }
}
