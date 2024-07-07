//
//  HomeController.swift
//  Movies-app
//
//  Created by Tatarella on 01.07.24.
//

import UIKit

class HomeController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    init() {
        super.init(title: "Movies")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.output = self
        viewModel.fetchData()
    }
}

extension HomeController: HomeViewModelOutput {
    func reloadData(startIndex startIdenx: Int) {
        self.moviesList.performBatchUpdates({
            let indexPaths = (startIdenx..<self.viewModel.movies.count).map { IndexPath(item: $0, section: 0) }
            self.moviesList.insertItems(at: indexPaths)
        })
    }
}

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let curr = viewModel.movies[indexPath.row]
        cell.configure(title: curr.title ?? "", image: curr.getPosterPath())
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curr = viewModel.movies[indexPath.row]
        let detailsViewModel = DetailsViewModel(movieId: curr.id)
        let detailVC = MovieDetailsController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 1 {
            viewModel.fetchData()
        }
    }
}

