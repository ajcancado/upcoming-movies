//
//  Environment.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

enum Environment: Int {
    case development
    case production
}

extension Environment {
    
    static var current: Environment {
        
        get {
            return Environment(rawValue: UserDefaults.standard.integer(forKey: Constants.SessionKeys.environment))!
        }
        set (val) {
            UserDefaults.standard.set(val.hashValue, forKey: Constants.SessionKeys.environment)
        }
    }
}   
