//
//  MovieCollectionViewCell.swift
//  Movies-app
//
//  Created by Tatarella on 01.07.24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .colorText
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var itemTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = Typography.body
        label.textColor = .colorText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImage()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        loader.stopAnimating()
    }
    
    private func setupImage() {
       
        contentView.addSubview(loader)
        self.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 140),
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            loader.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            
        ])
    }
    
    private func setupLabel() {
        
        self.addSubview(itemTitle)
        
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            itemTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
        ])
    }
    
    func configure(title: String, image: String) {
        self.itemTitle.text = title
        if image != "NoImage", let imageURL = URL(string: image) {
            self.image.load(from: imageURL, with: loader)
        } else {
            self.image.image = UIImage(named: image)
        }
    }
}

