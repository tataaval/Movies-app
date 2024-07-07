//
//  SearchViewModel.swift
//  Movies-app
//
//  Created by Tatarella on 06.07.24.
//

import Foundation

protocol SearchViewModelType {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput? { get set }
}

protocol SearchViewModelInput {
    func fetchData(query: String?)
    func setSearchType(search: String)
}

protocol SearchViewModelOutput: AnyObject {
    func reloadData()
}

class SearchViewModel: NSObject, SearchViewModelType {
    
    private var currentPage = 1
    private var totalPages = 1
    private var query = ""
    var searchType = "Movie"
    
    
    var input: SearchViewModelInput { self }
    weak var output: SearchViewModelOutput?
    
    var movies: [MovieModel] = []
    var people: [PersonModel] = []
    
    private func fetchMovieData() {
        let baseURL = "https://api.themoviedb.org/"
        let path = "/3/search/movie"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(currentPage)"),
            URLQueryItem(name: "query", value: "\(self.query)"),
        ]

        guard currentPage <= self.totalPages else { return }
        
        NetworkService.shared.getData(baseURL: baseURL, path: path, queryItems: queryItems ) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(let response):
                self.movies.append(contentsOf: response.results ?? [])
                self.totalPages = response.totalPages
                self.currentPage += 1
                self.output?.reloadData()
            case .failure(_):
                print("დაფიქსირდა შეცდომა!")
            }
        }
    }
    
    private func fetchPersonData() {
        let baseURL = "https://api.themoviedb.org/"
        let path = "/3/search/person"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(currentPage)"),
            URLQueryItem(name: "query", value: "\(self.query)"),
        ]

        guard currentPage <= self.totalPages else { return }
        
        NetworkService.shared.getData(baseURL: baseURL, path: path, queryItems: queryItems ) { (result: Result<PersonResponseModel, Error>) in
            switch result {
            case .success(let response):
                self.people.append(contentsOf: response.results ?? [])
                self.totalPages = response.totalPages
                self.currentPage += 1
                self.output?.reloadData()
            case .failure(_):
                print("დაფიქსირდა შეცდომა!")
            }
        }
    }
    
}


extension SearchViewModel: SearchViewModelInput{

    func fetchData(query: String?) {
        if let query{
            self.query = query
            self.currentPage = 1
            self.movies = []
            self.people = []
        }
        
        if searchType == "Movie" {
            fetchMovieData()
        } else {
            fetchPersonData()
        }
    }
    
    func setSearchType(search: String) {
        self.searchType = search
    }
}

