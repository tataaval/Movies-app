//
//  DetailsViewModel.swift
//  Movies-app
//
//  Created by Tatarella on 04.07.24.
//

import Foundation

protocol DetailsViewModelType {
    var input: DetailsViewModelInput { get }
    var output: DetailsViewModelOutput? { get }
}

protocol DetailsViewModelInput {
    func loadDetails()
}

protocol DetailsViewModelOutput: AnyObject {
    func configureView()
}

class DetailsViewModel: NSObject, DetailsViewModelType {
    var input: DetailsViewModelInput { self }
    weak var output: DetailsViewModelOutput?
    
    var details: DetailsModel?
    
    private var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
}

extension DetailsViewModel: DetailsViewModelInput{
    func loadDetails() {
        let baseURL = "https://api.themoviedb.org/"
        let path = "/3/movie/\(self.movieId)"
        
        NetworkService.shared.getData(baseURL: baseURL, path: path ) { (result: Result<DetailsModel, Error>) in
            switch result {
            case .success(let response):
                self.details = response
                self.output?.configureView()
            case .failure(_):
                print("კიდევ სცადე, ღმერთი შენკენ!")
            }
        }
        
    }
}

