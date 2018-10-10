//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

struct Movie: Codable {
    
    let voteCount: Int
    let id: Int
    let video: Bool
    let voteAverage: Float
    let title: String
    let popularity: Double
    let posterPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    func assemblePosterUrl() -> String? {
        
        if let poster = self.posterPath {
            return Constants.API.imageURL + poster
        }
        
        if let backdrop = self.backdropPath {
            return Constants.API.imageURL + backdrop
        }
        
        return nil
    }
    
    func assembleGenreStringFrom(_ genres: [Genre]) -> String {
        
        var genresString: [String] = []
        
        genreIds.forEach { genreId in
            
            if let genre = genres.first(where: {$0.id == genreId}) {
                genresString.append(genre.name)
            }
        }
        
        return genresString.joined(separator:", ")
    }
    
}
