//
//  MovieCell.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 29/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static var identifier: String { return "MovieCellIdentifier" }


    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
}
