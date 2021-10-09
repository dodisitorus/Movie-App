//
//  UIViewController.swift
//  SBTest
//
//  Created by Dodi Sitorus on 09/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }
}
