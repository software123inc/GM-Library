//
//  Proficiency.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/22/25.
//

import Foundation
import SwiftData

enum ProficiencyType: String, Codable {
    case savingThrow
    case skill
}

@Model
class Proficiency: Decodable, CustomStringConvertible {
    #Index<Proficiency>([\.name])
    var id:UUID = UUID()
    var name: String = "unspecified proficiency"
    var modifier: Int = 0
    var type:ProficiencyType? = nil
//    @Relationship(deleteRule: .cascade) var monster: Monster? // Single relationship
    @Relationship(deleteRule: .cascade) var monsterA5e: Monster_A5e? // Single relationship
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case modifier = "Modifier"
        case type = "Type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "unspecified proficiency"
        self.modifier = try container.decodeIfPresent(Int.self, forKey: .modifier) ?? 0
        self.type = try container.decodeIfPresent(ProficiencyType.self, forKey: .type)
    }
    
    init(name: String, modifier: Int) {
        self.name = name
        self.modifier = modifier
    }
    
    var description: String {
        "{name: \(name), modifier: \(modifier)}"
    }
}
