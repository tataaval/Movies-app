//
//  DetailsModel.swift
//  Movies-app
//
//  Created by Tatarella on 04.07.24.
//

import Foundation

struct DetailsModel: Codable {
    let backdropPath: String?
    let genres: [Genre]?
    let id: Int
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id, overview, runtime, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

extension DetailsModel {
    
    func getBackdrop() -> String {
        guard let backdropPath else { return "NoImage"}
        return "https://image.tmdb.org/t/p/w440_and_h660_face\(backdropPath)"
    }
    
    func getPoster() -> String {
        guard let posterPath else { return "NoImage"}
        return "https://image.tmdb.org/t/p/w440_and_h660_face\(posterPath)"
    }
    
    func getGenres() -> String {
        guard let genres else { return ""}
        if genres.count > 0 {
            return "\(genres[0].name)"
        }
        return ""
    }
}
