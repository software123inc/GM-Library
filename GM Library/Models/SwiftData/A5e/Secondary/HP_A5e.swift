//
//  HP.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation
import SwiftData

@Model
class HP_A5e: Decodable {
    var id:UUID = UUID()
    var value: Int = 0
    var notes: String?
    
    var monsterA5e: Monster_A5e?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case notes = "Notes"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.value = try container.decode(Int.self, forKey: .value)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
    }
}
