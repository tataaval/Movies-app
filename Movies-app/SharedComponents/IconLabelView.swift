//
//  IconLabelView.swift
//  Movies-app
//
//  Created by Tatarella on 03.07.24.
//

import UIKit

class IconLabelView: UIView {

    private let iconImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
       
       private let label: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = Typography.body
           label.textColor = .colorText
           return label
       }()
       
       init(icon: UIImage?) {
           super.init(frame: .zero)
           setupView(icon: icon)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func setupView(icon: UIImage?) {
           addSubview(iconImageView)
           addSubview(label)
           
           iconImageView.image = icon
           
           NSLayoutConstraint.activate([
            
               iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
               iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
               iconImageView.widthAnchor.constraint(equalToConstant: 16),
               iconImageView.heightAnchor.constraint(equalToConstant: 16),
               
               label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
               label.trailingAnchor.constraint(equalTo: trailingAnchor),
               label.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
       }
    
    func configure(text: String, color: UIColor = .colorText) {
        self.label.text = text
        self.label.textColor = color
    }

}
