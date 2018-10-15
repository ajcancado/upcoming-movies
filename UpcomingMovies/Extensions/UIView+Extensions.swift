//
//  UIView+Extensions.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cançado on 09/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundView() {
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func shadowView() {
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        self.layer.shouldRasterize = true
    }
}
