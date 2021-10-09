//
//  UIImageView.swift
//  SBTest
//
//  Created by Dodi Sitorus on 08/10/21.
//

import Foundation
import UIKit

@IBDesignable
class ShimmerImageView: UIImageView {
    
    let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: - Start Animating
        startAnimatingShimmer()
        
        self.image = .none
    }
    
    var gradientColorOne : CGColor = UIColor(displayP3Red: 0.92143100499999997, green: 0.92145264149999995, blue: 0.92144101860000005, alpha: 0.7).cgColor
    
    var gradientColorTwo : CGColor = UIColor(displayP3Red: 0.83741801979999997, green: 0.83743780850000005, blue: 0.83742713930000001, alpha: 0.6).cgColor
    
    func getGradientLayer() -> CAGradientLayer {
        
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    func getAnimation() -> CABasicAnimation {
       
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.2
        return animation
    }
    
    func startAnimatingShimmer() {

        let gradientLayer = getGradientLayer()

        let animation = getAnimation()

        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}

