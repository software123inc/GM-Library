//
//  SpecialAbility.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import Foundation
import SwiftData

@Model
class SpecialAbility: Decodable {
    var id:UUID = UUID()
    var name: String = ""
    var desc: String?
    
    
    @Relationship(deleteRule: .cascade, inverse: \DifficultyCheck.specialAbility) var dc: DifficultyCheck?
    @Relationship(deleteRule: .cascade, inverse: \SpellCasting.specialAbility) var spellCasting:SpellCasting?
//    @Relationship(deleteRule: .cascade)
    var monsterWoTC: Monster_WoTC? // Single relationship

    enum CodingKeys: String, CodingKey {
        case name
        case desc
        case dc
        case spellcasting
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        dc = try container.decodeIfPresent(DifficultyCheck.self, forKey: .dc)
        spellCasting = try container.decodeIfPresent(SpellCasting.self, forKey: .spellcasting)
    }
}
