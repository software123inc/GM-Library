//
//  Action.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  https://stackoverflow.com/questions/72121226/how-to-decode-json-value-that-can-be-either-string-or-int

import SwiftData
import Foundation

@Model
class Action: Decodable {
    var id:UUID = UUID()
    var name: String = "unnamed"
    var desc: String?
    var multiattackType: String?
    var attackBonus: Int?
    
    @Relationship(deleteRule: .cascade, inverse: \MonsterDamage.action) var damage: [MonsterDamage]? = []
    @Relationship(deleteRule: .cascade, inverse: \SubAction.action) var subActions: [SubAction]? = []
    @Relationship(deleteRule: .cascade, inverse: \DifficultyCheck.action) var dc: DifficultyCheck?
    
//    @Relationship(deleteRule: .cascade)
    var monster: Monster_WoTC? // Single relationship

    enum CodingKeys: String, CodingKey {
        case name
        case desc
        case multiattackType = "multiattack_type"
        case attackBonus = "attack_bonus"
        case dc, damage, subActions = "actions"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        multiattackType = try container.decodeIfPresent(String.self, forKey: .multiattackType)
        attackBonus = try container.decodeIfPresent(Int.self, forKey: .attackBonus)
        dc = try container.decodeIfPresent(DifficultyCheck.self, forKey: .dc)
        damage = try container.decodeIfPresent([MonsterDamage].self, forKey: .damage) ?? []
        subActions = try container.decodeIfPresent([SubAction].self, forKey: .subActions) ?? []
    }
}


