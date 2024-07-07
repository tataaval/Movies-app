//
//  MovieDescriptionView.swift
//  Movies-app
//
//  Created by Tatarella on 04.07.24.
//

import UIKit

protocol MovieDescriptionViewDelegate: AnyObject{
    func favouriteButtonClicked()
}

class MovieDescriptionView: UIView {
    
    weak var delegate: MovieDescriptionViewDelegate?
    
    private var about: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.heading5
        label.textColor = .colorText
        label.text = "About Movie"
        return label
    }()
    
    private var desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Typography.body
        label.textColor = .colorText
        return label
    }()
    
    private var favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .colorGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupMovieDescriptionView()
        favouriteButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.favouriteButton.isSelected.toggle()
            self.favouriteButton.tintColor = self.favouriteButton.isSelected ? .red : .gray
            self.delegate?.favouriteButtonClicked()
        }), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMovieDescriptionView() {
        self.addSubview(about)
        self.addSubview(favouriteButton)
        self.addSubview(desc)
        
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .colorDivider
        
        self.addSubview(divider)
        
        NSLayoutConstraint.activate([
            about.topAnchor.constraint(equalTo: self.topAnchor),
            about.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: about.trailingAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            divider.heightAnchor.constraint(equalToConstant: 4),
            divider.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            desc.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            desc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            desc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
        ])
    }
    
    func configure(desc: String, isFavorite: Bool) {
        self.desc.text = desc
        if isFavorite {
            self.favouriteButton.isSelected = true
            self.favouriteButton.tintColor = .red
        }
    }
    
}
