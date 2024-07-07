//
//  MovieTitleView.swift
//  Movies-app
//
//  Created by Tatarella on 03.07.24.
//

import UIKit

class MovieTitleView: UIView {

    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Typography.heading2
        label.textColor = .colorText
        return label
    }()
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .colorText
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setuphCoverView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuphCoverView() {
        self.addSubview(poster)
        self.addSubview(title)
        poster.addSubview(loader)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 120),
            poster.topAnchor.constraint(equalTo: self.topAnchor),
            poster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            poster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            poster.widthAnchor.constraint(equalToConstant: 95),
            
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            loader.centerXAnchor.constraint(equalTo: poster.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: poster.centerYAnchor),
            
        ])
    }
    
    func configure(image: String, title: String) {
        self.title.text = title
        if image != "NoImage", let imageURL = URL(string: image) {
            self.poster.load(from: imageURL, with: loader)
        } else {
            self.poster.image = UIImage(named: image)
        }
    }

}
