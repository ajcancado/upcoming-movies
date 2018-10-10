//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 04/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class MovieDetailViewModel {

    var movie: Movie!
    var genres: [Genre]!
    
    func getGenres() -> [String] {
        
        var genresString: [String] = []
        
        movie.genreIds.forEach { genreId in
            
            if let genre = self.genres.first(where: {$0.id == genreId}) {
                genresString.append(genre.name)
            }
        }
        
        return genresString
    }
    
    func getGenreIdName(_ id: Int) -> String{
        
        if let genre = self.genres.first(where: {$0.id == id}) {
            return genre.name
        }
        
        return Constants.Messages.empty
    }
    
}
