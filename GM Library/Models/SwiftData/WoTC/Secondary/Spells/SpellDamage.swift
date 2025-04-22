//
//  SpellDamage.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

@Model
class SpellDamage: Decodable, Identifiable {
    var id = UUID()
    
    @Relationship(deleteRule: .cascade, inverse: \SpellEffectAtCharacterLevel.spellDamage) var damage_at_character_level:SpellEffectAtCharacterLevel?
    @Relationship(deleteRule: .cascade, inverse: \SpellEffectAtSlotLevel.spellDamage) var damage_at_slot_level:SpellEffectAtSlotLevel?
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.spellDamage) var damage_type: URL_WoTC?
    
    var spellWoTC: Spell_WoTC?
    
    enum CodingKeys: String, CodingKey {
        case damage_type
        case damage_at_slot_level
        case damage_at_character_level
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.damage_type = try container.decodeIfPresent(URL_WoTC.self, forKey: .damage_type)
        self.damage_at_slot_level = try container.decodeIfPresent(SpellEffectAtSlotLevel.self, forKey: .damage_at_slot_level)
        self.damage_at_character_level = try container.decodeIfPresent(SpellEffectAtCharacterLevel.self, forKey: .damage_at_character_level)
    }
}
