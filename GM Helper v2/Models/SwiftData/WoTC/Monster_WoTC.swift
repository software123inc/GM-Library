//
//  Monster.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  CloudKit requires properties to have a value by default or be optional

import SwiftData
import SwiftUI
import SDWebImageSwiftUI

@Model
class Monster_WoTC: Decodable, Nameable, ImageSource {
    #Index<Monster_WoTC>(
        [\.id],
        [\.sourceId],
        [\.name],
        [\.type],
        [\.challengeRating]
    )
    
    var id:UUID = UUID()
    var sourceId: String = ""
    var source: String = "WoTC SRD 2014"
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var subtype: String?
    var alignment: String = ""
    @Relationship(deleteRule: .cascade, inverse: \ArmorClass.monster) var armorClasses: [ArmorClass]? = []
    var hitPoints: Int = 0
    var hitDice: String = ""
    var hitPointsRoll: String = ""
    var speed:Speed_WoTC?
    var strength: Int = 0
    var dexterity: Int = 0
    var constitution: Int = 0
    var intelligence: Int = 0
    var wisdom: Int = 0
    var charisma: Int = 0
    @Relationship(deleteRule: .cascade, inverse: \Proficiency_WoTC.monster) var proficiencies: [Proficiency_WoTC]? = []
    var damageVulnerabilities: [String]?
    var damageResistances: [String]?
    var damageImmunities: [String]?
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.monster) var conditionImmunities: [URL_WoTC]? = []
    var senses:Senses_WoTC?
    var languages:String = ""
    var challengeRating: Double = 0.0
    var proficiencyBonus: Int?
    var xp: Int = 0
    @Relationship(deleteRule: .cascade, inverse: \SpecialAbility.monster) var specialAbilities: [SpecialAbility]? = []
    @Relationship(deleteRule: .cascade, inverse: \Action.monster) var actions: [Action]? = []
    @Relationship(deleteRule: .cascade, inverse: \LegendaryAction.monster) var legendaryActions: [LegendaryAction]? = []
    var image: String?
    var url: String = ""

    @Relationship(deleteRule: .cascade, inverse: \Monster.monsterWoTC) var normalizedMonster: Monster?

    enum CodingKeys: String, CodingKey {
        case sourceId = "index"
        case name, size, type, subtype, alignment
        case hitPoints = "hit_points"
        case hitDice = "hit_dice", hitPointsRoll = "hit_points_roll"
        case challengeRating = "challenge_rating"
        case armorClasses = "armor_class"
        case speed
        case strength, dexterity, constitution, intelligence, wisdom, charisma
        case proficiencyBonus = "proficiency_bonus"
        case damageVulnerabilities = "damage_vulnerabilities"
        case damageResistances = "damage_resistances"
        case damageImmunities = "damage_immunities"
        case conditionImmunities = "condition_immunities"
        case senses, xp, languages, image, url
        case proficiencies, specialAbilities = "special_abilities"
        case actions, legendaryActions = "legendary_actions"
    }

    required init(from decoder: Decoder) throws {
        id = UUID()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sourceId = try container.decode(String.self, forKey: .sourceId)
        name = try container.decode(String.self, forKey: .name)
        size = try container.decode(String.self, forKey: .size)
        type = try container.decode(String.self, forKey: .type)
        subtype = try container.decodeIfPresent(String.self, forKey: .subtype)
        alignment = try container.decode(String.self, forKey: .alignment)
        armorClasses = try container.decodeIfPresent([ArmorClass].self, forKey: .armorClasses) ?? []
        hitPoints = try container.decode(Int.self, forKey: .hitPoints)
        hitPointsRoll = try container.decode(String.self, forKey: .hitPointsRoll)
        speed = try container.decodeIfPresent(Speed_WoTC.self, forKey: .speed)
        strength = try container.decode(Int.self, forKey: .strength)
        dexterity = try container.decode(Int.self, forKey: .dexterity)
        constitution = try container.decode(Int.self, forKey: .constitution)
        intelligence = try container.decode(Int.self, forKey: .intelligence)
        wisdom = try container.decode(Int.self, forKey: .wisdom)
        charisma = try container.decode(Int.self, forKey: .charisma)
        proficiencies = try container.decodeIfPresent([Proficiency_WoTC].self, forKey: .proficiencies) ?? []
        hitDice = try container.decode(String.self, forKey: .hitDice)
        damageVulnerabilities = try container.decodeIfPresent([String].self, forKey: .damageVulnerabilities) ?? []
        damageResistances = try container.decodeIfPresent([String].self, forKey: .damageResistances) ?? []
        damageImmunities = try container.decodeIfPresent([String].self, forKey: .damageImmunities) ?? []
        conditionImmunities = try container.decodeIfPresent([URL_WoTC].self, forKey: .conditionImmunities) ?? []
        senses = try container.decode(Senses_WoTC.self, forKey: .senses)
        languages = try container.decode(String.self, forKey: .languages)
        challengeRating = try container.decode(Double.self, forKey: .challengeRating)
        proficiencyBonus = try container.decodeIfPresent(Int.self, forKey: .proficiencyBonus)
        xp = try container.decode(Int.self, forKey: .xp)
        specialAbilities = try container.decodeIfPresent([SpecialAbility].self, forKey: .specialAbilities) ?? []
        actions = try container.decodeIfPresent([Action].self, forKey: .actions) ?? []
        legendaryActions = try container.decodeIfPresent([LegendaryAction].self, forKey: .legendaryActions) ?? []
        image = try container.decodeIfPresent(String.self, forKey: .image)
        url = try container.decode(String.self, forKey: .url)
    }
}

extension Monster_WoTC: Monstrous, ViewDataSource {
    static func listViewContent (_ listItem: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        let monster = listItem as! Monster_WoTC
        
        
        if let normalizedMonster = monster.normalizedMonster {
            return AnyView(
                NavigationLink(destination: MonsterDetailScreen(monster: normalizedMonster)) {
                    HStack {
                        monster.mmImageToken()
                        VStack(alignment: .leading) {
                            Text(monster.name)
                                .font(.headline)
                            Text(monster.type.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                        }
                    }
                }
            )
        }
        else {
            return AnyView(EmptyView())
        }
    }
}

extension Monster_WoTC: MonstrousDTO {
    func toSourceId() -> String { sourceId }
    func toSourceKeyRawValue() -> String { SourceKey.wotc.rawValue }
    func toName() -> String {  name }
    func toLink() -> String { url }
    func toVersion() -> String { "5.0.0" }
    func toDesc() -> String? { nil }
    func toType() -> String { type }
    func toSubtype() -> String? { subtype }
    func toSize() -> String? { size }
    func toAlignment() -> String? { alignment }
    func toHitPoints() -> Int { hitPoints }
    func toHitDice() -> String? { hitPointsRoll }
    func toArmorClass() -> Int { armorClasses?.first?.value ?? 0 }
    func toArmorType() -> String? { armorClasses?.first?.type }
    func toInitiativeModifier() -> Int { 0 }
    func toSpeed() -> [String] {
        let walkSpeed = speed?.walk ?? ""
        let burrowSpeed = speed?.burrow ?? ""
        let climbSpeed = speed?.climb ?? ""
        let flySpeed = speed?.fly ?? ""
        let hoverSpeed = (speed?.hover ?? false) ? "hover" : ""
        let swimSpeed = speed?.swim ?? ""
        
        var speeds: [String] = []
        if !walkSpeed.isEmpty { speeds.append(walkSpeed) }
        if !burrowSpeed.isEmpty { speeds.append("burrow: \(burrowSpeed)") }
        if !climbSpeed.isEmpty { speeds.append("climb: \(climbSpeed)") }
        if !flySpeed.isEmpty { speeds.append("fly: \(flySpeed)") }
        if !hoverSpeed.isEmpty { speeds.append("hover") }
        if !swimSpeed.isEmpty { speeds.append("swim: \(swimSpeed)") }
        
        return speeds
    }
    func toAbilities() -> Abilities {
        Abilities(str: strength, dex: dexterity, con: constitution, int: intelligence, wis: wisdom, cha: charisma)
    }
    func toDamageVulnerabilities() -> [String]? { damageVulnerabilities }
    func toDamageResistances() -> [String]? { damageResistances }
    func toDamageImmunities() -> [String]? { damageImmunities }
    func toConditionImmunities() -> [String]? {
        var conditionImms: [String] = []
        if let conditionImmunities = conditionImmunities {
            conditionImmunities.forEach { if let name = $0.name { conditionImms.append(name)} }
        }
        return nil
    }
    func toSenses() -> [String] {
        let blindsight = senses?.blindsight ?? ""
        let darkvision = senses?.darkvision ?? ""
        let passivePerception = senses?.passivePerception
        let tremorsense = senses?.tremorsense ?? ""
        let truesight = senses?.truesight ?? ""
        
        var senses: [String] = []
        if !blindsight.isEmpty { senses.append("blindsight: \(blindsight)") }
        if !darkvision.isEmpty { senses.append("darkvision: \(darkvision)") }
        if let passivePerception { senses.append("Passive Perception: \(passivePerception)") }
        if !tremorsense.isEmpty { senses.append("tremorsense: \(tremorsense)") }
        if !truesight.isEmpty { senses.append("truesight: \(truesight)") }
        
        return senses
    }
    func toLanguages() -> String { languages }
    func toSaves() -> [Proficiency]? { extractProficiencies("Saving Throw: ") }
    func toSkills() -> [Proficiency]? { extractProficiencies("Skill: ") }
    func toChallengeRating() -> Double { challengeRating }
    func toProficiencyBonus() -> Int? { nil }
    func toTraits() -> [ActionTrait]?  {
        var traits : [ActionTrait] = []
        
        if let specialAbilities {
            for ability in specialAbilities {
                traits
                    .append(
                        ActionTrait(
                            name: ability.name,
                            content: ability.desc ?? "no found",
                            type: .trait
                        )
                    )
            }
            
            return traits
        }
        
        return nil
    }
    func toActions() -> [ActionTrait]? {
        var results = [ActionTrait]()
        
        if let actions {
            for action in actions {
                results
                    .append(
                        ActionTrait(
                            name: action.name,
                            content: action.desc ?? "",
                            type: .action
                        )
                    )
            }
            
            return results
        }
        
        return nil
    }
    func toBonusActions() -> [ActionTrait]? { nil }
    func toReactions() -> [ActionTrait]? { nil }
    func toLegendaryActions() -> [ActionTrait]? {
        var results = [ActionTrait]()
        
        if let legendaryActions {
            for action in legendaryActions {
                results
                    .append(
                        ActionTrait(
                            name: action.name,
                            content: action.desc ?? "",
                            type: .legendary
                        )
                    )
            }
            
            return results
        }
        
        return nil
    }
    
    func toMythicActions() -> [ActionTrait]? { nil }
    func toCombat() -> String? { nil }
    func toVariants() -> [MonsterVariant]? { nil }
    func toXP() -> Int? { xp }
    
    // be sure to add trailing space to namePrefix
    private func extractProficiencies(_ namePrefix: String) -> [Proficiency]? {
        var results: [Proficiency] = []
        
        if let proficiencies {
            let profs = proficiencies.filter({ $0.details?.name?.contains(namePrefix) ?? false })
            
            if profs.count > 0 {
                for prof in profs {
                    let modifier = prof.value
                    let name = prof.details?.name?.replacingOccurrences(of: namePrefix, with: "") ?? ""
                    
                    results.append(Proficiency(name: name.firstCapitalized, modifier: modifier))
                }
                
                return results
            }
        }
        
        return nil
    }
}
