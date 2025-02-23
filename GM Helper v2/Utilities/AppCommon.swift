//
//  AppCommon.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import Foundation
import SwiftData

class AppCommon {
    static let shared = AppCommon()
    
    private init() {}
    
    let schema = Schema([
        Item.self,
        Spell_Ae5.self
    ])
    
}
