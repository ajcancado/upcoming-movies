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
    
    func c(_ id: Int) -> String{
        
        if let genre = self.genres.first(where: {$0.id == id}) {
            return genre.name
        }
        
        return Constants.Messages.empty
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfItemsInSection(section: Int) -> Int{
        
        if section == 1 {
            return 3
        }
        
        return 1
    }
    
    func heightOfItemsInSection(at indexPath :IndexPath) -> CGFloat{
        
        if indexPath.section == 0 {
            return 250
        }
        
        return 44
    }
    
    func getGenres() -> String {
        
        return movie.assembleGenreStringFrom(genres)
    }
    
}
