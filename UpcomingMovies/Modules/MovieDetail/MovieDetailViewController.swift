//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = viewModel.movie.title
        
        setupTableView()
    }
    
    func setupTableView(){
        
        tableView.register(OverviewCell.nib, forCellReuseIdentifier:OverviewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.imageCellId, for: indexPath)
            
            let imageView = cell.viewWithTag(1) as! UIImageView
            
            if let posterImage = self.viewModel.movie.assemblePosterUrl() {
                
                imageView.kf.setImage(with: URL(string: posterImage),
                                                  placeholder: nil,
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
            }
            
            return cell
            
        } else{
            
            if row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.defaultCellId, for: indexPath)
                
                cell.textLabel?.text = "Release date:"
                cell.detailTextLabel?.text = viewModel.movie.releaseDate
                
                return cell
            }
            else if row == 1{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.defaultCellId, for: indexPath)
                
                cell.textLabel?.text = "Genres:"
                cell.detailTextLabel?.text = viewModel.getGenres()
                
                return cell
                
            } else if row == 2 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.identifier, for: indexPath) as! OverviewCell
                
                cell.overViewLabel.text = viewModel.movie.overview
                
                return cell
            }
            
            return UITableViewCell()
        }
    }
    
}

extension MovieDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
