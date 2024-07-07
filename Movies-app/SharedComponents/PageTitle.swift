//
//  PageTitle.swift
//  Movies-app
//
//  Created by Tatarella on 01.07.24.
//

import UIKit

class PageTitle: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = .colorText
        self.font = Typography.heading1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
