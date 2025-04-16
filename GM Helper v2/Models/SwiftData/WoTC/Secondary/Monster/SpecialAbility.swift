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
    var dc: DifficultyCheck?
    var spellCasting:SpellCasting?
    
    @Relationship(deleteRule: .cascade) var monster: Monster_WoTC? // Single relationship

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

@Model
class SpellCasting: Decodable {
    var id:UUID = UUID()
    var slots: SpellSlots?
    var spells: [URL_WoTC]?
    
    enum CodingKeys: String, CodingKey {
        case slots
        case spells
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slots = try container.decodeIfPresent(SpellSlots.self, forKey: .slots)
        spells = try container.decodeIfPresent([URL_WoTC].self, forKey: .spells)
    }
}
