//
//  Movie.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let originalTitle: String
    let popularity: Double
    let posterPath: String
    let voteCount: Double
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case voteCount = "vote_count"
    }
}

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let results: [SimilarMovie]
}

// MARK: - Result
struct SimilarMovie: Codable {
    let genreIDS: [Int]
    let originalTitle: String
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}


