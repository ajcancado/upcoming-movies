//
//  Constants.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

typealias JSON = Dictionary<String, Any>

struct Constants {
    
    struct API {
        static var baseURL: String {
            switch Environment.current {
            case .development:
                return "https://api.themoviedb.org/3/"
            case .production:
                return "https://api.themoviedb.org/3/"
            }
        }
        static let imageURL = "https://image.tmdb.org/t/p/w500/"
        
        static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
        
        static let language = "en-US"
    }
    
    struct SessionKeys {
        
        static let environment = "environment"
    }
    
    struct SegueIds {
        
        static let segueToMovieDetail = "segueToMovieDetail"
    }
    
    struct CellIds{
        
        static let defaultCellId = "RightDetailCellID"
        static let imageCellId = "ImageCellID"
    }
    
    struct Messages {
        
        static let empty = ""
        
        static let ok = "Ok"
        
        static let cancel = "Cancel"
        
        static let pullToRefresh = "Pull to refresh"
        
        static let moviesTitle = "Up! Movies"
    
        static let defaultTile = "Up! Movies"
        
        static let youAreOffline = "You are offline."
    }
    
    struct date {
        
        static let input = "YYYY-MM-dd"
        static let output = "YYYY-MM-dd"
    }
    
}
