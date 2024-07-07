//
//  SearchController.swift
//  Movies-app
//
//  Created by Tatarella on 01.07.24.
//

import UIKit

class SearchController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private var moviesList = UITableView()
    private let personList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 13
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    private let titleLabel = PageTitle(text: "Search")
    private var searchbar = SearchBar()
    private let emptyListMessage = EmptyListMessageView(title: "oh no isn’t this so embarrassing? ", text: "I cannot find anything with this name.")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorBg
        setupTitle()
        setupSearchBar()
        setupTabelView()
        setupCollectionView()
        setupMessageView()
        searchbar.delegate = self
        viewModel.output = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false 
        view.addGestureRecognizer(tapGesture)
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
    
    private func setupSearchBar(){
        view.addSubview(searchbar)
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchbar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            searchbar.heightAnchor.constraint(equalToConstant: 40)
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
            moviesList.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 30),
            moviesList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    private func setupMessageView(){
        view.addSubview(emptyListMessage)
        emptyListMessage.translatesAutoresizingMaskIntoConstraints = false
        emptyListMessage.isHidden = true
        
        NSLayoutConstraint.activate([
            
            emptyListMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyListMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
            emptyListMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
        ])
    }
    
    private func setupCollectionView() {
        
        personList.delegate = self
        personList.dataSource = self
        
        personList.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        personList.translatesAutoresizingMaskIntoConstraints = false
        personList.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        personList.backgroundColor = .clear
        
        view.addSubview(personList)
        
        NSLayoutConstraint.activate([
            
            personList.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 30),
            personList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func updateView() {
        if viewModel.movies.isEmpty && viewModel.people.isEmpty {
            emptyListMessage.isHidden = false
            moviesList.isHidden = true
            personList.isHidden = true
        } else {
            emptyListMessage.isHidden = true
            if viewModel.searchType == "Movie" {
                moviesList.isHidden = false
                personList.isHidden = true
            } else {
                moviesList.isHidden = true
                personList.isHidden = false
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension SearchController: SearchViewModelOutput {
    func reloadData() {
        self.moviesList.reloadData()
        self.personList.reloadData()
        self.updateView()
    }
}

extension SearchController: SearchBarDelegate {
    func typeDidUpdate(search: String) {
        self.viewModel.searchType = search
        self.updateView()
    }
    
    func handleSearch(keyword: String) {
        self.viewModel.fetchData(query: keyword)
    }
    
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let curr =  viewModel.movies[indexPath.row]
        cell.configure(title: curr.formattedTitle ?? "" , image: curr.getPosterPath(), releaseDate: curr.releaseDate ?? "", voteAvarage: curr.voteAvarage ?? 0, type: "Movie")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curr = viewModel.movies[indexPath.row]
        let detailsViewModel = DetailsViewModel(movieId: curr.id )
        let detailVC = MovieDetailsController(viewModel: detailsViewModel)
        self.present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.movies.count - 1 ) {
            viewModel.fetchData(query: nil)
        }
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let curr =  viewModel.people[indexPath.row]
        cell.configure(title: curr.title ?? "" , image: curr.getPosterPath())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 66) / 3
        return CGSize(width: width, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.people.count - 1 ) {
            viewModel.fetchData(query: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curr = viewModel.people[indexPath.row]
        let detailsViewModel = PersonDetailsViewModel(person: curr)
        let detailVC = PersonDetailsViewController(viewModel: detailsViewModel)
        self.present(detailVC, animated: true)
    }
}
