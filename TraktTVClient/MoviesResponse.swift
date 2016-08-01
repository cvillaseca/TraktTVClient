//
//  MoviesResponse.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 31/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Foundation
import SwiftyJSON

class MoviesResponse: NSObject {

    static func fromJSON(json: JSON) -> [Movie] {
        var results = [Movie]()
        if let items = json.array {
            for item in items {
                let title = item["title"].stringValue
                let year = item["year"].stringValue
                let overview = item["overview"].stringValue
                let pictureUrl = item["images"]["poster"]["thumb"].stringValue
                
                let movie = Movie(title: title, year: year, overview: overview, pictureUrl: pictureUrl)
                results.append(movie)
            }
        } 
        
        return results
    }

}
