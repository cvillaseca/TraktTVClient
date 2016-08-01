//
//  UIImageView.swift
//  TraktTVClient
//
//  Created by Cristian Villaseca on 31/7/16.
//  Copyright © 2016 Cristian Villaseca. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    public func setDownloadedImageWithURL(URL: NSURL) -> RetrieveImageTask
    {
        return self.kf_setImageWithURL(URL)
        
    }
}
