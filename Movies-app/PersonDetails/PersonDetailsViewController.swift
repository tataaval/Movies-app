//
//  PersonDetailsViewController.swift
//  Movies-app
//
//  Created by Tatarella on 07.07.24.
//

import UIKit

class PersonDetailsViewController: UIViewController {
    
    var viewModel: PersonDetailsViewModel
    private var moviesList = UITableView()
    private let titleLabel: PageTitle
    
    init(viewModel: PersonDetailsViewModel) {
        self.viewModel = viewModel
        self.titleLabel = PageTitle(text: viewModel.person.title ?? "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorBg
        setupTitle()
        setupTabelView() 
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
    
    private func setupTabelView() {
        moviesList.dataSource = self
        moviesList.delegate = self
        view.addSubview(moviesList)
        
        moviesList.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        moviesList.separatorStyle = .none
        moviesList.separatorColor = .clear
        moviesList.backgroundColor = .clear
        
        moviesList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviesList.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            moviesList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

extension PersonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.person.knowFor.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let curr =  viewModel.person.knowFor[indexPath.row]
        cell.configure(title: curr.formattedTitle ?? "" , image: curr.getPosterPath(), releaseDate: curr.releaseDate ?? "", voteAvarage: curr.voteAvarage ?? 0, type: curr.mediaType ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
