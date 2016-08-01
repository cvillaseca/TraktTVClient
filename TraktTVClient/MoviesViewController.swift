//
//  MoviesViewController.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var presenter : MoviesPresenter?
    
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        configureView()
        presenter?.loadMovies();
    }
    
    private func configureView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85.0
        title = "TrackTVClient"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }

}

extension MoviesViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie:Movie
        if searchController.active && searchController.searchBar.text != "" {
            if indexPath.row == movies.count - 1 {
                filterContentForSearchText(searchController.searchBar.text!)
            }
            movie = filteredMovies[indexPath.row]
        } else {
            if indexPath.row == movies.count - 1 {
                presenter?.loadMovies()
            }
            movie = movies[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MovieCell.identifier , forIndexPath: indexPath) as! MovieCell
        
        cell.lblTitle.text = movie.title
        cell.lblYear.text = movie.year
        cell.lblOverview.text = movie.overview
        cell.imgMovie.setDownloadedImageWithURL(NSURL(string: movie.pictureUrl ?? "")!)
        
        return cell
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        if searchBar.text != "" {
            filterContentForSearchText(searchBar.text!)
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if searchBar.text != "" && searchController.active {
            filterContentForSearchText(searchBar.text!)
        } else {
            presenter?.loadMovies()
        }
    }
}

extension MoviesViewController: MoviesProtocol {
    
    func showLoading() {
        tableView.hidden = true
        loadingIndicator.hidden = false
    }
    
    func hideLoading() {
        tableView.hidden = false
        loadingIndicator.hidden = true
    }
    
    func showError(errorDescription:String) {
        let alertController = UIAlertController(title: "Error", message: errorDescription, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func didLoadMovies(movies:[Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func didLoadFilteredMovies(movies: [Movie]) {
        self.filteredMovies = movies
        tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
//        filteredCandies = candies.filter({( candy : Candy) -> Bool in
//            let categoryMatch = (scope == "All") || (candy.category == scope)
//            return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
//        })
        presenter?.searchMovie(title: searchText)
    }
    
}
