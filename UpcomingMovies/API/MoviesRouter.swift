//
//  MoviesRouter.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit
import Alamofire

enum MoviesRouter: URLRequestConvertible{
    
    case getGenres([String: Any])
    case getUpcomingMovies([String: Any])
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getGenres:
            return .get
        case .getUpcomingMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getGenres:
            return "genre/movie/list"
        case .getUpcomingMovies:
            return "movie/upcoming"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: Constants.API.baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getGenres(let parameters):
             return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        case .getUpcomingMovies(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
