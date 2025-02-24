//
//  FilterDimensions.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation
import SwiftData

@Model
class FilterDimensions_A5e: Decodable {
    var id:UUID = UUID()
    var level: String = "0"
    var filterType: String = "Unknown"
        
    enum CodingKeys:String, CodingKey {
        case level = "Level"
        case filterType = "Type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.level = try container.decode(String.self, forKey: .level)
        self.filterType = try container.decode(String.self, forKey: .filterType)
    }
}
