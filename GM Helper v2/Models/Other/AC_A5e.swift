//
//  AC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation

class AC_A5e: Decodable {
    var value: Int = 0
    var notes: String?
    
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
