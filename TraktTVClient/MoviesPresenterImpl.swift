//
//  MoviesPresenterImpl.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Foundation

class MoviesPresenterImpl: NSObject, MoviesPresenter {
    
    private weak var view: MoviesProtocol?
    
    private let movieRepository: MoviesRepository
    
    init(view: MoviesProtocol, movieRepository: MoviesRepository) {
        self.view = view
        self.movieRepository = movieRepository
    }
    
    func loadMovies() {
        self.view?.showLoading()
        movieRepository.getMovies { (movies, error) in
            self.view?.hideLoading()
            
            if let mError = error {
                self.view?.showError(mError.localizedDescription)
            }
            
            if let newMovies = movies {
                self.view?.didLoadMovies(newMovies)
            }
            
        }
    }
    
    func loadMoreMovies() {
        movieRepository.getMovies { (movies, error) in
            
            if let mError = error {
                self.view?.showError(mError.localizedDescription)
            }
            
            if let newMovies = movies {
                self.view?.didLoadMovies(newMovies)
            }
            
        }
    }
    
    func searchMovie(title title:String) {
        movieRepository.getMovies(bySearch: title) { (movies, error) in
            if let mError = error {
                self.view?.showError(mError.localizedDescription)
            }
            
            if let newMovies = movies {
                self.view?.didLoadFilteredMovies(newMovies)
            }
        }
    }
}

