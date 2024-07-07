//
//  SearchTableViewCell.swift
//  Movies-app
//
//  Created by Tatarella on 06.07.24.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    private let releaseDate = IconLabelView(icon: UIImage(named: "Calendar"))
    private let imdb = IconLabelView(icon: UIImage(named: "Star"))
    private let type = IconLabelView(icon: UIImage(named: "Ticket"))

    let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.heading4
        label.textColor = .colorText
        return label
    }()
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .colorText
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code error")
    }
    
    private func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [imdb, releaseDate, type])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contentContainerView)
        
        contentContainerView.addSubview(image)
        contentContainerView.addSubview(label)
        contentContainerView.addSubview(stackView)
        contentContainerView.addSubview(loader)
        
        NSLayoutConstraint.activate([
            
            contentContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            contentContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            contentContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            contentContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            image.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 95),
            image.heightAnchor.constraint(equalToConstant: 120),

            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            loader.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: image.centerYAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        loader.stopAnimating()
    }
    
    func configure(title: String, image: String, releaseDate: String, voteAvarage: Double, type: String) {
        self.label.text = title
        self.imdb.configure(text: "\(voteAvarage.rounded(toPlaces: 1))", color: .colorYellow)
        self.releaseDate.configure(text: releaseDate)
        self.type.configure(text: type)
        if image != "NoImage", let imageURL = URL(string: image) {
            loader.startAnimating()
            self.image.sd_setImage(with: imageURL, placeholderImage: nil, options: [], completed: { [weak self] (downloadedImage, error, cacheType, url) in
                self?.loader.stopAnimating()
                if let error = error {
                    print("Failed to load image: \(error.localizedDescription)")
                    self?.image.image = UIImage(named: "image")
                } else {
                    self?.image.image = downloadedImage
                }
            })
        } else {
            self.image.image = UIImage(named: image)
        }
    }

}
