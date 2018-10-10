//
//  MoviesViewController.swift
//  UpcomingMovies
//
//  Created by Arthur Junqueira Cancado on 03/10/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit
import PKHUD
import Kingfisher

class MoviesViewController: UIViewController {
    
    let viewModel = MoviesViewModel()
        
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSearchController()
        
        setupTableView()
        
        setupViewModelBinds()
        
        fetchData()
        
        if traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = Constants.Messages.moviesTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = Constants.Messages.empty
    }
    
    func setupSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        
        tableView.register(MovieCell.nib, forCellReuseIdentifier:MovieCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setupViewModelBinds() {
        
        viewModel.showLoadingHud.bind { [weak self] visible in
            if let `self` = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
        
        viewModel.showErrorAlert.bind { [weak self] visible in
            
            if let `self` = self {
                
                if visible {
                    
                    let message = Constants.Messages.youAreOffline
                    
                    let alertController = UIAlertController(title: Constants.Messages.defaultTile, message: message, preferredStyle: .alert)
                
                    alertController.addAction(UIAlertAction(title: Constants.Messages.ok, style: .default))
                
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    func fetchData() {
        
        viewModel.fetchGenres {
            self.viewModel.fetchMovies {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        viewModel.filteredMovies = viewModel.movies.filter({( movie: Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.SegueIds.segueToMovieDetail {
            
            let svc = segue.destination as! MovieDetailViewController

            let indexPath = tableView.indexPathForSelectedRow
            
            let movie: Movie
            
            if isFiltering() {
                movie = viewModel.filteredMovies[indexPath!.row]
            } else {
                movie = viewModel.getMovie(at: indexPath!)
            }

            svc.viewModel.movie = movie
            svc.viewModel.genres = viewModel.genres
        }
    }
}

extension MoviesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return viewModel.filteredMovies.count
        }
        
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movie: Movie
        
        if isFiltering() {
            movie = viewModel.filteredMovies[indexPath.row]
        } else {
            movie = viewModel.getMovie(at: indexPath)
        }
        
        if let posterImage = movie.assemblePosterUrl() {
        
            cell.moviePosterImage.kf.setImage(with: URL(string: posterImage),
                                              placeholder: nil,
                                              options: [.transition(.fade(1))],
                                              progressBlock: nil,
                                              completionHandler: nil)
            
        }
        
        
        cell.movieTitleLabel.text = movie.title.capitalized
        
        cell.movieGenreLabel.text = viewModel.getGenres(at: indexPath)
        
        cell.movieReleaseDateLabel.text = movie.releaseDate
        
        return cell
    }
    
}

extension MoviesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !isFiltering() && indexPath.row >= viewModel.movies.count-1 && viewModel.page < viewModel.totalPages {
            
            viewModel.page += 1
            
            viewModel.fetchMovies {
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.SegueIds.segueToMovieDetail, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        
        let movieDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailID") as! MovieDetailViewController

        let movie: Movie
        
        if isFiltering() {
            movie = viewModel.filteredMovies[indexPath.row]
        } else {
            movie = viewModel.getMovie(at: indexPath)
        }
        
        movieDetailViewController.viewModel.movie = movie
        movieDetailViewController.viewModel.genres = viewModel.genres
        
        return movieDetailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
