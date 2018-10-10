//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

     let viewModel = MovieDetailViewModel()
    
    
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    @IBOutlet weak var movieGenresLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        
        self.navigationItem.title = viewModel.movie.title
        
        self.moviePosterImageView.kf.setImage(with: URL(string: self.viewModel.movie.assemblePosterUrl()),
                    placeholder: nil,
                    options: [.transition(.fade(1))],
                    progressBlock: nil,
                    completionHandler: nil)
        
        self.movieReleaseDateLabel.text = viewModel.movie.releaseDate
        
        self.movieDescriptionLabel.text = viewModel.movie.overview
    }

}
