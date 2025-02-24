//
//  Proficiency_WoTC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import Foundation
import SwiftData

@Model
class Proficiency_WoTC: Decodable {
    var id:UUID = UUID()
    var value: Int = 0
    var details: URL_WoTC?
    
    @Relationship(deleteRule: .cascade) var monster: Monster_WoTC? // Single relationship

    enum CodingKeys: String, CodingKey {
        case value, details = "proficiency"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(Int.self, forKey: .value)
        details = try container.decodeIfPresent(URL_WoTC.self, forKey: .details)
    }
}
