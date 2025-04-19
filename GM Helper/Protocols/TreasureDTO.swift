//
//  TreasureDTO.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/18/25.
//

import Foundation
protocol TreasureDTO {
    func toTreasure(treasureA5e:Treasure_A5e?, treasureWoTC:Treasure_WoTC?) -> Treasure
    
    func toSourceKeyRawValue() -> String
    func toSource() -> String
    func toName() -> String
    func toItemType() -> String
    func toRarity() -> String
    func toCost() -> String
    func toRequiresAttunement() -> Bool
    func toCraftingComponents() -> String?
    func toDesc() -> String
}

extension TreasureDTO {
    func toTreasure(treasureA5e:Treasure_A5e? = nil, treasureWoTC:Treasure_WoTC? = nil) -> Treasure {
        Treasure(
            sourceKeyRawValue: toSourceKeyRawValue(),
            source: toSource(),
            name: self.toName(),
            item_type: self.toItemType(),
            rarity: self.toRarity(),
            cost: self.toCost(),
            requires_attunement: self.toRequiresAttunement(),
            crafting_components: self.toCraftingComponents(),
            desc: self.toDesc(),
            treasureA5e: treasureA5e,
            treasureWoTC: treasureWoTC
        )
    }
}
