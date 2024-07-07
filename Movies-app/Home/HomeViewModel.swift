//
//  HomeViewModel.swift
//  Movies-app
//
//  Created by Tatarella on 03.07.24.
//

import Foundation

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput? { get set }
}

protocol HomeViewModelInput {
    func fetchData()
}

protocol HomeViewModelOutput: AnyObject {
    func reloadData(startIndex: Int)
}

class HomeViewModel: NSObject, HomeViewModelType {
    
    private var currentPage = 1
    private var totalPages = 1
    
    var movies: [MovieModel] = []
    
    
    var input: HomeViewModelInput { self }
    weak var output: HomeViewModelOutput?
    
}

extension HomeViewModel: HomeViewModelInput{
    func fetchData() {
        let baseURL = "https://api.themoviedb.org/"
        let path = "/3/movie/top_rated"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(currentPage)"),
        ]
        
        guard currentPage <= self.totalPages else { return }
        
        NetworkService.shared.getData(baseURL: baseURL, path: path, queryItems: queryItems ) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(let response):
                let startIndex = self.movies.count
                self.movies.append(contentsOf: response.results ?? [])
                self.totalPages = response.totalPages
                self.currentPage += 1
                self.output?.reloadData(startIndex: startIndex)
            case .failure(_):
                print("დაფიქსირდა შეცდომა!")
            }
        }
    }
}
