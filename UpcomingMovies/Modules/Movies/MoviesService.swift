//
//  MoviesService.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Alamofire

class MoviesService {
    
    let decoder = JSONDecoder()
    
    func fetchGenres(with params: JSON, completion: @escaping (_ genres: [Genre]?, _ error: Error?) -> ()) {
        
        Alamofire.request(MoviesRouter.getGenres(params))
            .responseData { response in
                
                switch response.result {
                    
                case .success(let json):
            
                    let genresResponse = try! self.decoder.decode(GenresResponse.self, from: json)
                    
                    completion(genresResponse.genres, nil)
                case .failure(let error):
                    completion(nil,error)
                }
        }
        
    }
    
    func fetchUpcomingMovies(with params: JSON, completion: @escaping (_ gameResponse: MoviesResponse?, _ error: Error?) -> ()) {
        
        Alamofire.request(MoviesRouter.getUpcomingMovies(params))
            .responseString { response in
                
                switch response.result {
                    
                case .success(let json):
                    
                    let data = json.data(using: .utf8)!
    
                    let moviesResponse = try! self.decoder.decode(MoviesResponse.self, from: data)
                    
                    completion(moviesResponse, nil)
                    
                case .failure(let error):
                    
                    completion(nil,error)
                }
        }
    }
    
    
    
}
