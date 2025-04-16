//
//  WoTC_URL.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation
import SwiftData

enum UrlType: String, Codable {
    case spellSchool
    case characterClass
    case characterSubclass
}

@Model
class URL_WoTC: Decodable, Identifiable {
    #Index<URL_WoTC>([\.name])
    var id = UUID()
    var index: String?
    var name: String?
    var level: Int?
    var url: String?
    var type: UrlType? // New property to categorize the URL
    
    @Relationship(deleteRule: .cascade) var spell: Spell_WoTC? // Single relationship
    @Relationship(deleteRule: .cascade) var monster: Monster_WoTC? // Single relationship
        
    enum CodingKeys: String, CodingKey {
        case index
        case name
        case level
        case url
        case type
    }
    
    init(index: String? = nil, name: String? = nil, level: Int? = nil, url: String? = nil, type: UrlType? = nil) {
        self.index = index
        self.name = name
        self.level = level
        self.url = url
        self.type = type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.index = try container.decodeIfPresent(String.self, forKey: .index)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.level = try container.decodeIfPresent(Int.self, forKey: .level)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.type = try container.decodeIfPresent(UrlType.self, forKey: .type)
    }
}
