//
//  Senses_WoTC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import Foundation
import SwiftData

@Model
class Senses_WoTC: Decodable {
    var id:UUID = UUID()
    var blindsight: String?
    var darkvision: String?
    var passivePerception: Int = 0
    var tremorsense: String?
    var truesight: String?
        
    enum CodingKeys: String, CodingKey {
        case blindsight = "blindsight"
        case darkvision = "darkvision"
        case passivePerception = "passive_perception"
        case tremorsense = "tremorsense"
        case truesight = "truesight"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        blindsight = try container.decodeIfPresent(String.self, forKey: .blindsight)
        darkvision = try container.decodeIfPresent(String.self, forKey: .darkvision)
        passivePerception = try container.decode(Int.self, forKey: .passivePerception)
        tremorsense = try container.decodeIfPresent(String.self, forKey: .tremorsense)
        truesight = try container.decodeIfPresent(String.self, forKey: .truesight)
    }
}
