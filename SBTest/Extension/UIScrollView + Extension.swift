//
//  UIScrollView + Extension.swift
//  SBTest
//
//  Created by Dodi Sitorus on 09/10/21.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func setupRefreshControl(selector: Selector, vc: UIViewController) {
        let control = UIRefreshControl()
        // refresh controll
        control.addTarget(vc, action: selector, for: .valueChanged)
        self.refreshControl = control
    }
}
