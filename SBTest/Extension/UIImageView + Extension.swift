//
//  UIImage + Extension.swift
//  SBTest
//
//  Created by Dodi Sitorus on 09/10/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageMask(color: UIColor, width: CGFloat) {
        
        if let image = self.image {
            
            let rectImage = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            
            image.draw(in: rectImage)
            
            let context = UIGraphicsGetCurrentContext()
            context?.setBlendMode(CGBlendMode.sourceIn)
            
            context?.setFillColor(color.cgColor)

            let rectContext = CGRect(origin: .zero, size: CGSize(width: image.size.width * width, height: image.size.height))
            context?.fill(rectContext)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self.image = newImage
        }
    }
}
