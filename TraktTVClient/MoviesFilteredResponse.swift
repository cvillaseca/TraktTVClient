//
//  MoviesFilteredResponse.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 1/8/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Foundation
import SwiftyJSON

class MoviesFilteredResponse: NSObject {
    static func fromJSON(json: JSON) -> [Movie] {
        var results = [Movie]()
        if let items = json.array {
            for item in items {
                let title = item["movie"]["title"].stringValue
                let year = item["movie"]["year"].stringValue
                let overview = item["movie"]["overview"].stringValue
                let pictureUrl = item["movie"]["images"]["poster"]["thumb"].stringValue
                
                let movie = Movie(title: title, year: year, overview: overview, pictureUrl: pictureUrl)
                results.append(movie)
            }
        }
        
        return results
    }
}
