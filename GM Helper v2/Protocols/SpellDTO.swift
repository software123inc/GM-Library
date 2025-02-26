//
//  SpellDTO.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import Foundation

protocol SpellDTO {
    func toSpell(spellA5e:Spell_A5e?, spellWoTC:Spell_WoTC?) -> Spell
    
    func toSourceId() -> String
    func toSourceKeyRawValue() -> String
    func toSource() -> String
    func toName() -> String
    func toLink() -> String
    func toDesc() -> String
    func toConcentration() -> Bool
    func toRange() -> String
    func toLevel() -> Int
    func toRitual() -> Bool
    func toCastingTime() -> String
    func toDuration() -> String
    func toSchool() -> String
    func toClasses() -> [String]
    func toComponents() -> String
}

extension SpellDTO {
    func toSpell(spellA5e:Spell_A5e? = nil, spellWoTC:Spell_WoTC? = nil) -> Spell {
        Spell(
            sourceId: toSourceId(),
            sourceKeyRawValue: toSourceKeyRawValue(),
            source: toSource(),
            name: toName(),
            link: toLink(),
            desc: toDesc(),
            concentration: toConcentration(),
            range: toRange(),
            level: toLevel(),
            ritual: toRitual(),
            castingTime: toCastingTime(),
            duration: toDuration(),
            school: toSchool(),
            classes: toClasses(),
            components: toComponents(),
            spellA5e: spellA5e,
            spellWoTC: spellWoTC
        )
    }
}
