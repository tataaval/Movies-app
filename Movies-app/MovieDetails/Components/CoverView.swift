//
//  CoverView.swift
//  Movies-app
//
//  Created by Tatarella on 03.07.24.
//

import UIKit

class CoverView: UIView {
    
    private let imdb = IconLabelView(icon: UIImage(named: "Star"))
    
    private var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var rating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.layer.cornerRadius = 8
        return label
    }()
    
    private var ratingWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 37/255, green: 40/255, blue: 54/255, alpha: 0.82)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomRight, .bottomLeft], radius: 16.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuphCoverView() {
        self.addSubview(cover)
        self.addSubview(ratingWrapper)
        cover.addSubview(loader)
        
        ratingWrapper.addSubview(imdb)
        imdb.translatesAutoresizingMaskIntoConstraints = false
        
        cover.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            
            cover.topAnchor.constraint(equalTo: self.topAnchor),
            cover.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cover.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cover.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ratingWrapper.trailingAnchor.constraint(equalTo: cover.trailingAnchor, constant: -20),
            ratingWrapper.bottomAnchor.constraint(equalTo: cover.bottomAnchor, constant: -20),
            ratingWrapper.heightAnchor.constraint(equalToConstant: 24),
            ratingWrapper.widthAnchor.constraint(equalToConstant: 54),
            
            imdb.centerXAnchor.constraint(equalTo: ratingWrapper.centerXAnchor),
            imdb.centerYAnchor.constraint(equalTo: ratingWrapper.centerYAnchor),
            
            loader.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
            
        ])
    }
    
    
    func configure(image: String, voteAvarage: Double ) {
        self.imdb.configure(text: "\(voteAvarage.rounded(toPlaces: 1))", color: .colorYellow)
        if image != "NoImage", let imageURL = URL(string: image) {
            self.cover.load(from: imageURL, with: loader)
        } else {
            self.cover.image = UIImage(named: image)
        }
    }    
}

