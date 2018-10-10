//
//  OverviewCell.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cançado on 09/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var overViewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
