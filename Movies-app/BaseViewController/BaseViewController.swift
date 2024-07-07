//
//  BaseViewController.swift
//  Movies-app
//
//  Created by Tatarella on 07.07.24.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let titleLabel: PageTitle
    
    let moviesList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 13
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    init(title: String) {
        self.titleLabel = PageTitle(text: title)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorBg
        setupTitle()
        setupCollectionView()
    }
    
    private func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
        ])
    }
    
    private func setupCollectionView() {
        moviesList.delegate = self
        moviesList.dataSource = self
        
        moviesList.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        moviesList.translatesAutoresizingMaskIntoConstraints = false
        moviesList.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        moviesList.backgroundColor = .clear
        
        view.addSubview(moviesList)
        
        NSLayoutConstraint.activate([
            moviesList.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            moviesList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("numberOfItemsInSection has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("cellForItemAt has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 66) / 3
        return CGSize(width: width, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fatalError("didSelectItemAt has not been implemented")
    }
}
