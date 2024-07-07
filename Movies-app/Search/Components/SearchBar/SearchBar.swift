//
//  SearchBar.swift
//  Movies-app
//
//  Created by Tatarella on 06.07.24.
//

import UIKit

protocol SearchBarDelegate: AnyObject{
    func handleSearch(keyword: String)
    func typeDidUpdate(search: String)
}

class SearchBar: UIView {
    
    private var debouncer: Debouncer?
    weak var delegate: SearchBarDelegate?
    
    var selectedOption: String = "Movie" {
        didSet {
            configureDropdown()
            self.textField.text = ""
            self.delegate?.typeDidUpdate(search: selectedOption)
        }
    }
    
    let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Dropdown"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .colorText
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorDivider
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .none
        textField.textColor = .colorText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Search")
        imageView.tintColor = .colorText
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        SetupInput()
        SetupDrowpDown()
        configureDropdown()
        debouncer = Debouncer(delay: 1) { [weak self] in
            guard let query = self?.textField.text else { return }
            self?.handleSearch(query: query)
        }
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDropdown() {
        let movieAction = UIAction(title: "Movie", image: selectedOption == "Movie" ? UIImage(systemName: "checkmark") : nil, handler: { _ in
            print("movie")
            self.selectedOption = "Movie"
        })
        
        let personAction = UIAction(title: "Person", image: selectedOption == "Person" ? UIImage(systemName: "checkmark") : nil, handler: { _ in
            print("Person")
            self.selectedOption = "Person"
        })
        
        let menu = UIMenu(title: "", children: [movieAction, personAction])
        
        dropdownButton.menu = menu
        dropdownButton.showsMenuAsPrimaryAction = true
    }
    
    private func SetupInput(){
        self.addSubview(containerView)
        
        containerView.addSubview(searchIconImageView)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchIconImageView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -20),
            searchIconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 20),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    private func SetupDrowpDown() {
        self.addSubview(dropdownButton)
        
        NSLayoutConstraint.activate([
            dropdownButton.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10),
            dropdownButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dropdownButton.widthAnchor.constraint(equalToConstant: 50),
            dropdownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        debouncer?.call()
    }
    
    private func handleSearch(query: String) {
        self.delegate?.handleSearch(keyword: query)
    }
}
