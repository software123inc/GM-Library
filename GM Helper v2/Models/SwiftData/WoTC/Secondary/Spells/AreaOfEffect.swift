//
//  AreaOfEffect.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

@Model
class AreaOfEffect: Decodable, Identifiable {
    #Index<AreaOfEffect>([\.type])
    var id = UUID()
    var type: String = "unspecified type"
    var size: Int = 0
        
    enum CodingKeys: String, CodingKey {
        case type
        case size
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(String.self, forKey: .type)
        self.size = try container.decode(Int.self, forKey: .size)
    }
}
