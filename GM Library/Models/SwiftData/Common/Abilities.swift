//
//  Abilities.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation
import SwiftData

@Model
class Abilities: Decodable, CustomStringConvertible {
    var id = UUID()
    var str: Int = 0
    var dex: Int = 0
    var con: Int = 0
    var int: Int = 0
    var wis: Int = 0
    var cha: Int = 0
    
    var monster: Monster?
    var monsterA5e: Monster_A5e?
    
    enum CodingKeys: String, CodingKey {
        case str = "Str"
        case dex = "Dex"
        case con = "Con"
        case int = "Int"
        case wis = "Wis"
        case cha = "Cha"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.str = try container.decode(Int.self, forKey: .str)
        self.dex = try container.decode(Int.self, forKey: .dex)
        self.con = try container.decode(Int.self, forKey: .con)
        self.int = try container.decode(Int.self, forKey: .int)
        self.wis = try container.decode(Int.self, forKey: .wis)
        self.cha = try container.decode(Int.self, forKey: .cha)
    }
    
    init(str: Int = 10, dex: Int = 10, con: Int = 10, int: Int = 10, wis: Int = 10, cha: Int = 10) {
        self.str = str
        self.dex = dex
        self.con = con
        self.int = int
        self.wis = wis
        self.cha = cha
    }
    
    var description: String {
        "{str: \(str), dex: \(dex), con: \(con), int: \(int), wis: \(wis), cha: \(cha)}"
    }
}
