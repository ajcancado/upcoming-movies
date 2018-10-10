//
//  MoviesResponse.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

struct MoviesResponse: Codable {
    
    let results: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        
    }
}
