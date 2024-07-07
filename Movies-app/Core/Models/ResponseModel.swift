//
//  ResponseModel.swift
//  Movies-app
//
//  Created by Tatarella on 02.07.24.
//

import Foundation

struct ResponseModel: Codable {
    let page: Int
    let results: [MovieModel]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieModel: Codable {
    let id: Int
    let posterPath: String?
    let title: String?
    let name: String?
    let releaseDate: String?
    let firstAirDate: String?
    let voteAvarage: Double?
    let mediaType: String?
    

    enum CodingKeys: String, CodingKey {
        case id, title, name
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAvarage = "vote_average"
        case firstAirDate = "first_air_date"
        case mediaType = "media_type"
    }
}

extension MovieModel {
    var formattedDate: String? {
        return releaseDate ?? firstAirDate
    }
    
    var formattedTitle: String? {
        return title ?? name
    }
    
    func getPosterPath() -> String {
        guard let posterPath else { return "NoImage"}
        return "https://image.tmdb.org/t/p/w440_and_h660_face\(posterPath)"
    }
}

