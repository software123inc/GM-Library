//
//  AppCommon.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import Foundation
import SwiftData
import SwiftUI

class AppCommon {
    static let shared = AppCommon()
    
    private init() {}
    
    let schema = Schema([
        Item.self,
        Monster.self,
        Monster_A5e.self,
        Monster_WoTC.self,
        Spell.self,
        Spell_A5e.self,
        Spell_WoTC.self
    ])
    
    var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
}
