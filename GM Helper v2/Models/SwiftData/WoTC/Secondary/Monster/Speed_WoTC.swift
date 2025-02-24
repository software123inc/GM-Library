//
//  Speed_WoTC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import Foundation
import SwiftData

@Model
class Speed_WoTC: Decodable {
    var id:UUID = UUID()
    var burrow:String?
    var climb:String?
    var fly:String?
    var hover:Bool?
    var swim:String?
    var walk:String?
        
    enum CodingKeys: String, CodingKey {
        case burrow
        case climb
        case fly
        case hover
        case swim
        case walk
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        burrow = try container.decodeIfPresent(String.self, forKey: .burrow)
        climb = try container.decodeIfPresent(String.self, forKey: .climb)
        fly = try container.decodeIfPresent(String.self, forKey: .fly)
        hover = try container.decodeIfPresent(Bool.self, forKey: .hover)
        swim = try container.decodeIfPresent(String.self, forKey: .swim)
        walk = try container.decodeIfPresent(String.self, forKey: .walk)
    }
}
