//
//  SpellEffectAtCharacterLevel.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

@Model
class SpellEffectAtCharacterLevel: Decodable, Identifiable {
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
    var level10: String?
    var level11: String?
    var level12: String?
    var level13: String?
    var level14: String?
    var level15: String?
    var level16: String?
    var level17: String?
    var level18: String?
    var level19: String?
    var level20: String?
    
    var spellDamage: SpellDamage?
        
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
        case level10 = "10"
        case level11 = "11"
        case level12 = "12"
        case level13 = "13"
        case level14 = "14"
        case level15 = "15"
        case level16 = "16"
        case level17 = "17"
        case level18 = "18"
        case level19 = "19"
        case level20 = "20"
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
        self.level10 = try container.decodeIfPresent(String.self, forKey: .level10)
        self.level11 = try container.decodeIfPresent(String.self, forKey: .level11)
        self.level12 = try container.decodeIfPresent(String.self, forKey: .level12)
        self.level13 = try container.decodeIfPresent(String.self, forKey: .level13)
        self.level14 = try container.decodeIfPresent(String.self, forKey: .level14)
        self.level15 = try container.decodeIfPresent(String.self, forKey: .level15)
        self.level16 = try container.decodeIfPresent(String.self, forKey: .level16)
        self.level17 = try container.decodeIfPresent(String.self, forKey: .level17)
        self.level18 = try container.decodeIfPresent(String.self, forKey: .level18)
        self.level19 = try container.decodeIfPresent(String.self, forKey: .level19)
        self.level20 = try container.decodeIfPresent(String.self, forKey: .level20)
    }
}
