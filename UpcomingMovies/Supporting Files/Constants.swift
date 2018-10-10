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
    
    struct Messages {
        
        static let empty = ""
        
        static let ok = "Ok"
        
        static let cancel = "Cancel"
        
        static let pullToRefresh = "Pull to refresh"
        
        static let gamesTitle = "Upcoming Movies"
    
        static let defaultTile = "Up! Movies"
        
        static let youAreOffline = "You are offline."
    }
    
    struct date {
        
        static let input = "YYYY-MM-dd"
        static let output = "YYYY-MM-dd"
    }
    
    static let totalItem: CGFloat = 20
    
    static let column: CGFloat = 3
    
    static let minLineSpacing: CGFloat = 1.0
    static let minItemSpacing: CGFloat = 1.0
    
    static let offset: CGFloat = 1.0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        
        // totalCellWidth = (collectionview width or tableview width) - (left offset + right offset) - (total space x space width)
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
    
}

extension Notification.Name {
    static let saveGames = Notification.Name("save_games")
}
