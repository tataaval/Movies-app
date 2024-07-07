//
//  MovieDetailsController.swift
//  Movies-app
//
//  Created by Tatarella on 02.07.24.
//

import UIKit

class MovieDetailsController: UIViewController {
        
    var viewModel: DetailsViewModel
    
    private let coverView = CoverView()
    private let titleView = MovieTitleView()
    private let generalInfoView = GeneralInfoView()
    private let movieDescriptionView = MovieDescriptionView()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDescriptionView.delegate = self
        setupUI()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.output = self
        self.viewModel.loadDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorBg
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.colorText
        ]
        
        setupCoverView()
        setupTitleView()
        setupGeneralInfoView()
        setupDescriptionView()
    }
    
    private func setupCoverView() {
        view.addSubview(coverView)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            coverView.heightAnchor.constraint(equalToConstant: 210),
            coverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
    }
    
    private func setupTitleView() {
        view.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleView.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant: -60),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
    
    private func setupGeneralInfoView() {
        view.addSubview(generalInfoView)
        generalInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalInfoView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            generalInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalInfoView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupDescriptionView() {
        view.addSubview(movieDescriptionView)
        movieDescriptionView.isUserInteractionEnabled = true
        movieDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            movieDescriptionView.topAnchor.constraint(equalTo: generalInfoView.bottomAnchor, constant: 34),
            movieDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDescriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    private func configureWithData() {
        self.navigationItem.title = self.viewModel.details?.title
        self.coverView.configure(image: self.viewModel.details?.getBackdrop() ?? "", 
                                 voteAvarage: self.viewModel.details?.voteAverage ?? 0)
        self.titleView.configure(image: self.viewModel.details?.getPoster() ?? "",
                                 title: self.viewModel.details?.title ?? "No Name")
        self.generalInfoView.configure(releaseDate: self.viewModel.details?.releaseDate ?? "",
                                       duration: "\(self.viewModel.details?.runtime ?? 0) minutes",
                                       genre: self.viewModel.details?.getGenres() ?? "")
        self.movieDescriptionView.configure(desc: self.viewModel.details?.overview ?? "", 
                                            isFavorite: FavouritesManager.shared.isFavorite(self.viewModel.details!.id))
    }
}

extension MovieDetailsController: MovieDescriptionViewDelegate {
    func favouriteButtonClicked() {
        let currentMovie = FavoriteItem(id: self.viewModel.details!.id, title: self.viewModel.details!.title, posterPath: self.viewModel.details!.posterPath ?? "")
        FavouritesManager.shared.toggleItem(currentMovie)
    }
}

extension MovieDetailsController: DetailsViewModelOutput{
    func configureView() {
        configureWithData()
    }
}

