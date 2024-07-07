//
//  PersonResponseModel.swift
//  Movies-app
//
//  Created by Tatarella on 07.07.24.
//

import Foundation

struct PersonResponseModel: Codable {
    let page: Int
    let results: [PersonModel]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct PersonModel: Codable {
    let id: Int?
    let posterPath: String?
    let title: String?
    let knowFor: [MovieModel]
    

    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case posterPath = "profile_path"
        case knowFor = "known_for"
    }
}

extension PersonModel {
    func getPosterPath() -> String {
        guard let posterPath else { return "NoImage"}
        return "https://image.tmdb.org/t/p/w440_and_h660_face\(posterPath)"
    }
}
