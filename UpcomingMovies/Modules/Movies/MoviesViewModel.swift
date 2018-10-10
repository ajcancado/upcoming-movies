//
//  MoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class MoviesViewModel {
    
    let moviesService = MoviesService()
    
    let showLoadingHud: Bindable = Bindable(false)
    
    let showErrorAlert: Bindable = Bindable(false)
    
    var genres: [Genre] = []
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    var page: Int = 1
    var totalPages: Int = 1
    
    func fetchGenres(completion: @escaping ()->()) {
        
        var params: JSON = [:]
        
        params["api_key"] = Constants.API.apiKey
        params["language"] = Constants.API.language
        
        showLoadingHud.value = true
        
        moviesService.fetchGenres(with: params, completion: { [weak self] result, error in
            
            self?.showLoadingHud.value = false
            
            if let genres = result {
                
                self?.genres = genres
                
            } else if let _ = error {
                
                self?.showErrorAlert.value = true
            }
            
            completion()
        })
        
    }
    
    func fetchMovies(completion: @escaping ()->()) {
        
        var params: JSON = [:]
        
        params["api_key"] = Constants.API.apiKey
        params["language"] = Constants.API.language
        params["page"] = page
        
        showLoadingHud.value = true
        
        moviesService.fetchUpcomingMovies(with: params, completion: { [weak self] result, error in
            
            self?.showLoadingHud.value = false
            
            if let moviesResponse = result {
                
                self?.page = moviesResponse.page
                self?.totalPages = moviesResponse.totalPages
                self?.movies.append(contentsOf: moviesResponse.results)
                
            } else if let _ = error {
                
                self?.showErrorAlert.value = true
            }
            
            completion()
        })
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(section: Int) -> Int{
        return movies.count
    }
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }

    
    func getGenres(at indexPath: IndexPath) -> String {
        
        let movie = movies[indexPath.row]
        
        var genresString: [String] = []
        
        movie.genreIds.forEach { genreId in
            
            if let genre = self.genres.first(where: {$0.id == genreId}) {
                genresString.append(genre.name)
            }
        }
        
        return genresString.description
    }
}


