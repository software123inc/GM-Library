//
//  SpellDC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

@Model
class SpellDC: Decodable, Identifiable {
    var id = UUID()
    var dc_success:String = "unspecified success effect"
    
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.spellDC) var dc_type: URL_WoTC?
    var spellWoTC: Spell_WoTC?
    
    enum CodingKeys: String, CodingKey {
        case dc_type
        case dc_success
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dc_type = try container.decodeIfPresent(URL_WoTC.self, forKey: .dc_type)
        self.dc_success = try container.decode(String.self, forKey: .dc_success)
    }
}
