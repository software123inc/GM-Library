//
//  DifficultyCheck.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/23/25.
//

import Foundation
import SwiftData

@Model
class DifficultyCheck: Decodable {
    var id:UUID = UUID()
//    var dcType: URL_WoTC?
    var dcValue: Int = 0
    var successType: String = "unspecified"
    
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.difficultyCheck) var dcType: URL_WoTC? = nil
    var action:Action?
    var legendaryAction:LegendaryAction?
    var specialAbility:SpecialAbility?
    
    enum CodingKeys: String, CodingKey {
        case dcType = "dc_type"
        case dcValue = "dc_value"
        case successType = "success_type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dcType = try container.decodeIfPresent(URL_WoTC.self, forKey: .dcType)
        dcValue = try container.decode(Int.self, forKey: .dcValue)
        successType = try container.decode(String.self, forKey: .successType)
    }
}
