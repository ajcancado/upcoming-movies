//
//  GenresResponse.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

struct GenresResponse: Codable {
    
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        
        case genres = "genres"
    }
}
