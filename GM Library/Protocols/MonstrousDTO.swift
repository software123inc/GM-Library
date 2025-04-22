//
//  MonstrousDTO.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/22/25.
//

import Foundation

protocol MonstrousDTO {
    func toMonster(monsterA5e:Monster_A5e?, monsterWoTC:Monster_WoTC?) -> Monster
    
    func toSourceId() -> String
    func toSourceKeyRawValue() -> String
    func toName() -> String
    func toLink() -> String
    func toVersion() -> String
    func toDesc() -> String?
    func toType() -> String
    func toSubtype() -> String?
    func toSize() -> String?
    func toAlignment() -> String?
    func toHitPoints() -> Int
    func toHitDice() -> String?
    func toArmorClass() -> Int
    func toArmorType() -> String?
    func toInitiativeModifier() -> Int
    func toSpeed() -> [String]
    func toAbilities() -> Abilities
    func toDamageVulnerabilities() -> [String]?
    func toDamageResistances() -> [String]?
    func toDamageImmunities() -> [String]?
    func toConditionImmunities() -> [String]?
    func toSenses() -> [String]
    func toLanguages() -> String
    func toSaves() -> [Proficiency]?
    func toSkills() -> [Proficiency]?
    func toChallengeRating() -> Double
    func toProficiencyBonus() -> Int?
    func toTraits() -> [ActionTrait]?
    func toActions() -> [ActionTrait]?
    func toBonusActions() -> [ActionTrait]?
    func toReactions() -> [ActionTrait]?
    func toLegendaryActions() -> [ActionTrait]?
    func toMythicActions() -> [ActionTrait]?
    func toCombat() -> String?
    func toXP() -> Int?
}

extension MonstrousDTO {
    func toMonster(monsterA5e:Monster_A5e? = nil, monsterWoTC:Monster_WoTC? = nil) -> Monster {
        Monster(
            sourceId: toSourceId(),
            sourceKeyRawValue: toSourceKeyRawValue(),
            name: toName(),
            link: toLink(),
            version: toVersion(),
            desc: toDesc(),
            type: toType(),
            subtype: toSubtype(),
            size: toSize(),
            alignment: toAlignment(),
            hitPoints: toHitPoints(),
            hitDice: toHitDice(),
            armorClass: toArmorClass(),
            armorType: toArmorType(),
            initiativeModifier: toInitiativeModifier(),
            speed: toSpeed(),
            abilities: toAbilities(),
            damageVulnerabilities: toDamageVulnerabilities(),
            damageResistances: toDamageResistances(),
            damageImmunities: toDamageImmunities(),
            conditionImmunities: toConditionImmunities(),
            senses: toSenses(),
            languages: toLanguages(),
            saves: toSaves(),
            skills: toSkills(),
            challengeRating: toChallengeRating(),
            proficiencyBonus: toProficiencyBonus(),
            traits: toTraits(),
            actions: toActions(),
            bonusActions: toBonusActions(),
            reactions: toReactions(),
            legendaryActions: toLegendaryActions(),
            mythicActions: toMythicActions(),
            combat: toCombat(),
            xp: toXP(),
            monsterA5e: monsterA5e,
            monsterWoTC: monsterWoTC
        )
    }
}
