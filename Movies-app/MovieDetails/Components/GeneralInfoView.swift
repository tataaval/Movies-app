//
//  GeneralInfoView.swift
//  Movies-app
//
//  Created by Tatarella on 04.07.24.
//

import UIKit

class GeneralInfoView: UIView {
    
    private let releaseDate = IconLabelView(icon: UIImage(named: "Calendar"))
    private let duration = IconLabelView(icon: UIImage(named: "Clock"))
    private let genre = IconLabelView(icon: UIImage(named: "Ticket"))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupGeneralInfoView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGeneralInfoView() {
        let divider1 = createDivider()
        let divider2 = createDivider()
        
        let stackView = UIStackView(arrangedSubviews: [releaseDate, divider1, duration, divider2, genre])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    
    func configure(releaseDate: String, duration: String, genre: String ) {
        self.releaseDate.configure(text: releaseDate)
        self.duration.configure(text: duration)
        self.genre.configure(text: genre)
    }
    
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 16).isActive = true
        divider.backgroundColor = .lightGray
        return divider
    }
    
    
}
