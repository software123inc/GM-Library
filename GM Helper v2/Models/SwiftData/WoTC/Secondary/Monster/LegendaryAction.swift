//
//  LegendaryAction.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import Foundation
import SwiftData

@Model
class LegendaryAction: Decodable {
    var id:UUID = UUID()
    var name: String = ""
    var desc: String?
    var attackBonus: Int?
    var dc: DifficultyCheck?
    @Relationship(deleteRule: .cascade, inverse: \MonsterDamage.legendaryAction) var damage: [MonsterDamage]? = []

//    @Relationship(deleteRule: .cascade) var monster: Monster_WoTC? // Single relationship
    
    enum CodingKeys: String, CodingKey {
        case name
        case desc = "description"
        case attackBonus = "attack_bonus"
        case dc, damage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        attackBonus = try container.decodeIfPresent(Int.self, forKey: .attackBonus)
        dc = try container.decodeIfPresent(DifficultyCheck.self, forKey: .dc)
        self.damage = try container.decodeIfPresent([MonsterDamage].self, forKey: .damage) ?? []
    }
}
