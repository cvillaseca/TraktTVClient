//
//  MoviesProtocol.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Foundation

protocol MoviesProtocol:class {
    func showLoading()
    func hideLoading()
    func showError(errorDescription:String)
    func didLoadMovies(movies:[Movie])
    func didLoadFilteredMovies(movies:[Movie])
}
