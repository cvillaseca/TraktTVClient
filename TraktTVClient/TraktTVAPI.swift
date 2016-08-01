//
//  TraktTVAPI.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Alamofire
import SwiftyJSON

class TraktTVAPI: NSObject {
    
    static let sharedInstance = TraktTVAPI()
    
    let manager: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        return Manager(configuration: configuration)
    }()

    
    private let headers = [
        "Content-Type": "application/json",
        "trakt-api-key": Constants.ClientID,
        "trakt-api-version": "2"
    ]
    
    
    func getMovies(page: Int, limit: Int, completion:( movies:[Movie]?, error:NSError?)-> Void) {
        
        let params = ["page":page,
                      "limit":limit,
                      "extended":"full,images"] as [String:AnyObject]
        
        
        Alamofire.request(.GET,"\(Constants.APIEndPoint)/movies/popular", headers: headers, parameters:params).responseJSON { response in
            
            if let error = response.result.error {
                completion(movies: nil, error: error)
            } else {
                
                let json = JSON(response.result.value!)
                let movies = MoviesResponse.fromJSON(json)
                
                completion(movies: movies, error: nil)
            }
            
        }
    }
    
    func getMovies(searchText title:String, page: Int, limit: Int, completion:( movies:[Movie]?, error:NSError?)-> Void) {
        
        let params = ["page":page,
                      "limit":limit,
                      "query":title,
                      "extended":"full,images"] as [String:AnyObject]

        
        Alamofire.request(.GET,"\(Constants.APIEndPoint)/search/movie", headers: headers, parameters:params).responseJSON { response in
            
            if let error = response.result.error {
                completion(movies: nil, error: error)
            } else {
                
                let json = JSON(response.result.value!)
                let movies = MoviesFilteredResponse.fromJSON(json)
                
                completion(movies: movies, error: nil)
            }
            
        }
    }
    
}
