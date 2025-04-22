//
//  SpellEffectAtSlotLevel.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

@Model
class SpellEffectAtSlotLevel: Decodable, Identifiable {
    var id = UUID()
    var level1: String?
    var level2: String?
    var level3: String?
    var level4: String?
    var level5: String?
    var level6: String?
    var level7: String?
    var level8: String?
    var level9: String?
    
    var spellDamage: SpellDamage?
    var spellWoTC: Spell_WoTC?
    
    enum CodingKeys: String, CodingKey {
        case level1 = "1"
        case level2 = "2"
        case level3 = "3"
        case level4 = "4"
        case level5 = "5"
        case level6 = "6"
        case level7 = "7"
        case level8 = "8"
        case level9 = "9"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.level1 = try container.decodeIfPresent(String.self, forKey: .level1)
        self.level2 = try container.decodeIfPresent(String.self, forKey: .level2)
        self.level3 = try container.decodeIfPresent(String.self, forKey: .level3)
        self.level4 = try container.decodeIfPresent(String.self, forKey: .level4)
        self.level5 = try container.decodeIfPresent(String.self, forKey: .level5)
        self.level6 = try container.decodeIfPresent(String.self, forKey: .level6)
        self.level7 = try container.decodeIfPresent(String.self, forKey: .level7)
        self.level8 = try container.decodeIfPresent(String.self, forKey: .level8)
        self.level9 = try container.decodeIfPresent(String.self, forKey: .level9)
    }
}
