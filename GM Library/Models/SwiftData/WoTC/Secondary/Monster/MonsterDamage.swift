//
//  Damage.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import SwiftData
import Foundation

@Model
class MonsterDamage: Decodable {
    var id:UUID = UUID()
    var damageDice: String?
    
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.monsterDamage) var damageType: URL_WoTC?
//    @Relationship(deleteRule: .cascade)
    var action: Action? // Single relationship
//    @Relationship(deleteRule: .cascade)
    var legendaryAction: LegendaryAction? // Single relationship

    enum CodingKeys: String, CodingKey {
        case damageType = "damage_type"
        case damageDice = "damage_dice"
    }

    init(damageType: URL_WoTC? = nil, damageDice: String? = nil) {
        self.damageType = damageType
        self.damageDice = damageDice
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        damageType = try container.decodeIfPresent(URL_WoTC.self, forKey: .damageType)
        damageDice = try container.decodeIfPresent(String.self, forKey: .damageDice)
    }
}
