//
//  Int+Extensions.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/27/25.
//

import Foundation

extension Int {
    var ordinal: String {
        let formatter = {
            let ff = NumberFormatter()
            ff.numberStyle = .ordinal
            ff.locale = Locale.current
            
            return ff
        }()
        
       return "\(formatter.string(from: NSNumber(value: self)) ?? "")"
    }
}
