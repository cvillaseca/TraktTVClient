//
//  MoviesRepository.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 31/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Foundation

class MoviesRepository {
    
    private let traktTVApi : TraktTVAPI
    
    private lazy var movies = [Movie]()
    private lazy var searchMovies = [Movie]()
    private lazy var lastSearchedTitle = ""
    
    init (traktTVApi: TraktTVAPI) {
        self.traktTVApi = traktTVApi;
    }

    func getMovies(completion:(movies:[Movie]?, error:NSError?)->Void) {
        let page = (movies.count / Constants.PageSize) + 1;
        
        traktTVApi.getMovies(page, limit:Constants.PageSize) { (movies, error) in
            if let newMovies = movies {
                self.movies.appendContentsOf(newMovies)
            }
            completion(movies: self.movies, error: error)
        }
        
    }
    
    func getMovies(bySearch title:String, completion:(movies:[Movie]?, error:NSError?)->Void) {
        let page = (searchMovies.count / Constants.PageSize) + 1;
        
        if lastSearchedTitle != title {
            lastSearchedTitle = title
            self.searchMovies.removeAll()
        }
        
        traktTVApi.getMovies(searchText: title, page: page, limit:Constants.PageSize) { (movies, error) in
            if let newMovies = movies {
                self.searchMovies.appendContentsOf(newMovies)
            }
            completion(movies: self.searchMovies, error: error)
        }
        
    }
}
