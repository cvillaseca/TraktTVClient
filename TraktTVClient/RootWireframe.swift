//
//  RootWireframe.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 31/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {
    let window: UIWindow?
    
    lazy var traktTVApi = TraktTVAPI.sharedInstance
    
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func presentMovieList() {
        
        let moviesVC = UIStoryboard.main().instantiateInitialViewController() as! MoviesViewController
        let moviesRepository = MoviesRepository(traktTVApi: self.traktTVApi)
        
        let presenter = MoviesPresenterImpl(view: moviesVC, movieRepository: moviesRepository)
        moviesVC.presenter = presenter
        
        let navController = UINavigationController(rootViewController: moviesVC)
        window!.rootViewController = navController
    }
    
    func navigationController() -> UINavigationController {
        let navigationController = window!.rootViewController as! UINavigationController
        return navigationController
    }

}
