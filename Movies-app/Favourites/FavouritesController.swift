//
//  FavouritesController.swift
//  Movies-app
//
//  Created by Tatarella on 01.07.24.
//

import UIKit

class FavouritesController: BaseViewController {
    
    private let viewModel = FavouritesViewModel()
    
    private let emptyListMessage = EmptyListMessageView(title: "No favourites yet", text: "All moves marked as favourite will be added here")
    
    init() {
        super.init(title: "Favorites")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageView()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.output = self
        FavouritesManager.shared.delegate = viewModel
        viewModel.loadFavourites()
    }
    
    private func setupMessageView() {
        view.addSubview(emptyListMessage)
        emptyListMessage.translatesAutoresizingMaskIntoConstraints = false
        emptyListMessage.isHidden = true
        
        NSLayoutConstraint.activate([
            emptyListMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyListMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
            emptyListMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
        ])
    }
    
    private func updateView() {
        if viewModel.favorites.isEmpty {
            emptyListMessage.isHidden = false
            moviesList.isHidden = true
        } else {
            emptyListMessage.isHidden = true
            moviesList.isHidden = false
        }
    }
}

extension FavouritesController: FavouritesViewModelOutput {
    func reloadData() {
        self.moviesList.reloadData()
        updateView()
    }
}

extension FavouritesController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let curr = viewModel.favorites[indexPath.row]
        let bla = "https://image.tmdb.org/t/p/w440_and_h660_face/\(curr.posterPath)"
        cell.configure(title: curr.title, image: bla)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curr = viewModel.favorites[indexPath.row]
        let detailsViewModel = DetailsViewModel(movieId: curr.id)
        let detailVC = MovieDetailsController(viewModel: detailsViewModel)
        self.present(detailVC, animated: true)
    }
}
