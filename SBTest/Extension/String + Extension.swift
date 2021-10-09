//
//  String + Extension.swift
//  SBTest
//
//  Created by Dodi Sitorus on 08/10/21.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
