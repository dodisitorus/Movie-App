//
//  StarRating.swift
//  SBTest
//
//  Created by Dodi Sitorus on 09/10/21.
//

import Foundation
import UIKit

protocol IStarRating {
    
    var listImageStar: [UIImageView] { get set }
    
    func setColor(value: Double)
}

struct StarRating: IStarRating {
    
    var listImageStar: [UIImageView] = []
    
    func setColor(value: Double) {
        var ratingIn = value / 2
        
        for i in 0..<listImageStar.count {
            let imageView = listImageStar[i]
        
            if ratingIn != 0 {
                if ratingIn - 1 > 0 {
                    imageView.setImageMask(color: UIColor(displayP3Red: 29/255, green: 122/255, blue: 222/255, alpha: 1), width: 1)
                } else {
                    imageView.setImageMask(color: UIColor(displayP3Red: 29/255, green: 122/255, blue: 222/255, alpha: 1), width: ratingIn)
                }
                
                ratingIn -= 1
            }
        }
    }
}
