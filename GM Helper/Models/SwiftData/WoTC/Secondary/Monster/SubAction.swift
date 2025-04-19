//
//  SubAction.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import Foundation
import SwiftData

@Model
class SubAction: Decodable {
    var id:UUID = UUID()
    var actionName: String = ""
    var count: String = ""
    var type: String = ""
    
//    @Relationship(deleteRule: .cascade)
    var action: Action? // Single relationship
    
    enum CodingKeys: String, CodingKey {
        case actionName = "action_name"
        case count, type
    }
    
    init(actionName: String, count: String, type: String) {
        self.actionName = actionName
        self.count = count
        self.type = type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        actionName = try container.decode(String.self, forKey: .actionName)
        
        if let value = try? container.decode(Int.self, forKey: .count) {
            count = String(value)
        }
        else {
            count = try container.decode(String.self, forKey: .count)
        }
        type = try container.decode(String.self, forKey: .type)
    }
}
