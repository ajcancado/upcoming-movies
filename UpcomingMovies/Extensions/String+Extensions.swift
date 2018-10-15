//
//  String+Extensions.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

extension String {
    
    func toDateWithFormat(_ format: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)!
    }
    
    func toDateFrom(from input: String, to output: String) -> String {
        
        let date = self.toDateWithFormat(input)
        
        return date.toStringWithFormat(output)
    }
}
