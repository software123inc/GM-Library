//
//  MonsterVariant.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import Foundation
import SwiftData

@Model
class MonsterVariant: Decodable, CustomStringConvertible, Nameable {
    #Index<MonsterVariant>([\.id], [\.name])
    
    var id:UUID = UUID()
    var name: String = ""
    var desc: String = ""
    
    @Relationship(deleteRule: .cascade, inverse: \ActionTrait.monsterVariant) var traits: [ActionTrait]? = []
    @Relationship(deleteRule: .cascade, inverse: \Monster.monsterVariant) var monster: Monster?
    @Relationship(deleteRule: .cascade, inverse: \Monster_A5e.monsterVariant) @Relationship(deleteRule: .cascade) var monsterA5e: Monster_A5e?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case desc = "Description"
        case traits = "Traits"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
        
        // Decode each category and map to ActionTraits with appropriate ActionType; GROK 3
        var allActionTraits: [ActionTrait] = []
        if let traits = try container.decodeIfPresent([ActionTrait].self, forKey: .traits) {
            allActionTraits.append(contentsOf: traits.map { $0.type = .trait; return $0 })
        }
        
        self.traits = allActionTraits
    }
    
    var description: String {
        "{name: \(name), desc: \(desc), traits: \(String(describing: traits))}"
    }
}
