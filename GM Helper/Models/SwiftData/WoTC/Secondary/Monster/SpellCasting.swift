//
//  SpellCasting.swift
//  GM Helper
//
//  Created by Tim W. Newton on 4/18/25.
//

import Foundation
import SwiftData

@Model
class SpellCasting: Decodable {
    var id:UUID = UUID()
    
    @Relationship(deleteRule: .cascade, inverse: \SpellSlots.spellCasting) var slots: SpellSlots?
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.spellCasting) var spells: [URL_WoTC]?
    
    var specialAbility:SpecialAbility?
    
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
