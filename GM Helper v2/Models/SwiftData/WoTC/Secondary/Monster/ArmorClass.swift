//
//  ArmorClass.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import SwiftData
import Foundation

@Model
class ArmorClass: Decodable {
    var id:UUID = UUID()
    var type: String = ""
    var value: Int = 0
    
    @Relationship(deleteRule: .cascade) var monster: Monster_WoTC? // Single relationship

    enum CodingKeys: String, CodingKey {
        case type, value
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        value = try container.decode(Int.self, forKey: .value)
    }
}
