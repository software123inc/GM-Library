//
//  ActionTrait.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation
import SwiftData

enum ActionType: String, Codable {
    case noSet
    case trait
    case action
    case bonusAction
    case reaction
    case legendary
    case mythic
}

@Model
class ActionTrait: Decodable, CustomStringConvertible {
    #Index<ActionTrait>([\.name])
    var id:UUID = UUID()
    var name: String = "Unspecified Action/Trait"
    var content: String = "No content provided."
    var type: ActionType // New property to categorize the action/trait
    
    @Relationship(deleteRule: .cascade) var monster: Monster? // Single relationship
    @Relationship(deleteRule: .cascade) var monsterA5e: Monster_A5e? // Single relationship
    @Relationship(deleteRule: .cascade) var monsterVariant: MonsterVariant? // Single relationship
//
//    var monsterAction:Monster? = nil
//    var monsterBonusAction:Monster? = nil
//    var monsterReaction:Monster? = nil
//    var monsterLegendaryAction:Monster? = nil
//    var monsterMythic:Monster? = nil
//    var monsterTrait:Monster? = nil
//    var monsterVariantTrait:MonsterVariant? = nil
    
    init(name: String, content: String, type: ActionType = .noSet) {
        self.name = name
        self.content = content
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case content = "Content"
        case type = "Type" // Add this to decode the type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.content = try container.decode(String.self, forKey: .content)
        self.type = try container.decodeIfPresent(ActionType.self, forKey: .type) ?? .noSet
    }
    
    var description: String {
        "{name: \(name), content: \(content)}"
    }
}
