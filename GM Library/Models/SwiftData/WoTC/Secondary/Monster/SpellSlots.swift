//
//  SpellSlots.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/16/25.
//


import Foundation
import SwiftData

@Model
class SpellSlots: Decodable, Identifiable {
    var id = UUID()
    var level1: Int?
    var level2: Int?
    var level3: Int?
    var level4: Int?
    var level5: Int?
    var level6: Int?
    var level7: Int?
    var level8: Int?
    var level9: Int?
    
    var spellCasting:SpellCasting?
    
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
        
        self.level1 = try container.decodeIfPresent(Int.self, forKey: .level1)
        self.level2 = try container.decodeIfPresent(Int.self, forKey: .level2)
        self.level3 = try container.decodeIfPresent(Int.self, forKey: .level3)
        self.level4 = try container.decodeIfPresent(Int.self, forKey: .level4)
        self.level5 = try container.decodeIfPresent(Int.self, forKey: .level5)
        self.level6 = try container.decodeIfPresent(Int.self, forKey: .level6)
        self.level7 = try container.decodeIfPresent(Int.self, forKey: .level7)
        self.level8 = try container.decodeIfPresent(Int.self, forKey: .level8)
        self.level9 = try container.decodeIfPresent(Int.self, forKey: .level9)
    }
    
    func slotsAvailable(forLevel level:Int) -> Int? {
        switch level {
            case 0:
                return -1
            case 1:
                return level1
            case 2:
                return level2
            case 3:
                return level3
            case 4:
                return level4
            case 5:
                return level5
            case 6:
                return level6
            case 7:
                return level7
            case 8:
                return level8
            case 9:
                return level9
            default:
                return nil
        }
    }
}
