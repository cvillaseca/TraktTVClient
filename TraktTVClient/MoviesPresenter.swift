//
//  MoviesPresenter.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//


protocol MoviesPresenter: class {
    func loadMovies()
    func loadMoreMovies()
    func searchMovie(title title:String)
}

