//
//  Monster.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//
//  https://useyourloaf.com/blog/swiftdata-indexes/

import SwiftUI
import SwiftData

// MARK: - Monster Model
@Model
class Monster_A5e: Decodable, Nameable {
    #Index<Monster_A5e>([\.id], [\.sourceId], [\.name], [\.monsterType], [\.challenge])
    
    var id: UUID = UUID()
    var sourceId: String = ""
    var name: String = ""
    var path: String = ""
    var link: String = ""
    var filterDimensions: FilterDimensions_A5e? // SwiftData will not create a record in the table, but will embed it in Monster_A5e.
    var version: String = ""
    var source: String = ""
    var monsterType: String = ""
    var hp: HP_A5e?
    var ac: AC_A5e?
    var initiativeModifier: Int = 0
    var speed: [String]?
    var abilities: Abilities?
    var damageVulnerabilities: [String]? = []
    var damageResistances: [String]? = []
    var damageImmunities: [String]? = []
    var conditionImmunities: [String]? = []
    var senses: [String]? = []
    var languages: [String]? = []
    @Relationship(deleteRule: .cascade, inverse: \Proficiency.monsterA5e) private var proficiencies: [Proficiency] = [] // Single collection for all proficiencies; GROK 3
    var challenge: String = ""
    @Relationship(deleteRule: .cascade, inverse: \ActionTrait.monsterA5e) private var actionTraits: [ActionTrait] = [] // Single collection for all traits/actions; GROK 3
    var desc: String?
    var player: String?
    var imageURL: String?
    var combat: String?
    @Relationship(deleteRule: .cascade, inverse: \MonsterVariant.monsterA5e) var variants: [MonsterVariant]? = []
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "Id"
        case name = "Name"
        case path = "Path"
        case link = "Link"
        case filterDimensions = "FilterDimensions"
        case version = "Version"
        case source = "Source"
        case monsterType = "Type"
        case hp = "HP"
        case ac = "AC"
        case initiativeModifier = "InitiativeModifier"
        case speed = "Speed"
        case abilities = "Abilities"
        case damageVulnerabilities = "DamageVulnerabilities"
        case damageResistances = "DamageResistances"
        case damageImmunities = "DamageImmunities"
        case conditionImmunities = "ConditionImmunities"
        case senses = "Senses"
        case languages = "Languages"
        case saves = "Saves"
        case skills = "Skills"
        case challenge = "Challenge"
        case traits = "Traits"
        case actions = "Actions"
        case bonusActions = "BonusActions"
        case reactions = "Reactions"
        case legendaryActions = "LegendaryActions"
        case mythicActions = "MythicActions"
        case desc = "Desc"
        case player = "Player"
        case imageURL = "ImageURL"
        case combat = "Combat"
        case variants = "Variants"
    }
    
    // MARK: - Initializers
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sourceId = try container.decode(String.self, forKey: .sourceId)
        self.name = try container.decode(String.self, forKey: .name)
        self.path = try container.decode(String.self, forKey: .path)
        self.link = try container.decode(String.self, forKey: .link)
        self.filterDimensions = try container.decode(FilterDimensions_A5e.self, forKey: .filterDimensions)
        self.version = try container.decode(String.self, forKey: .version)
        self.source = try container.decode(String.self, forKey: .source)
        self.monsterType = try container.decode(String.self, forKey: .monsterType)
        self.hp = try container.decodeIfPresent(HP_A5e.self, forKey: .hp)
        self.ac = try container.decodeIfPresent(AC_A5e.self, forKey: .ac)
        self.initiativeModifier = try container.decode(Int.self, forKey: .initiativeModifier)
        self.speed = try container.decodeIfPresent([String].self, forKey: .speed) // Keep nil for distinction NOT SPECIFIED - no data in JSON file; Grok
        self.abilities = try container.decodeIfPresent(Abilities.self, forKey: .abilities)
        self.damageVulnerabilities = try container.decodeIfPresent([String].self, forKey: .damageVulnerabilities) ?? [] // Keep [] to specify that monster has NONE; Grok
        self.damageResistances = try container.decodeIfPresent([String].self, forKey: .damageResistances) ?? []
        self.damageImmunities = try container.decodeIfPresent([String].self, forKey: .damageImmunities) ?? []
        self.conditionImmunities = try container.decodeIfPresent([String].self, forKey: .conditionImmunities) ?? []
        self.senses = try container.decodeIfPresent([String].self, forKey: .senses) ?? [] // Could argue nil, but [] simplifies; Grok
        self.languages = try container.decodeIfPresent([String].self, forKey: .languages) ?? [] // Same
        self.challenge = try container.decode(String.self, forKey: .challenge)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.player = try container.decodeIfPresent(String.self, forKey: .player)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.combat = try container.decodeIfPresent(String.self, forKey: .combat)
        self.variants = try container.decodeIfPresent([MonsterVariant].self, forKey: .variants) // Keep nil for optional content; Grok
        
        // Decode each proficiency and map to Proficiency with appropriate ProficiencyType; GROK 3
        var allProficiencies: [Proficiency] = []
        if let saves = try container.decodeIfPresent([Proficiency].self, forKey: .saves) {
            allProficiencies.append(contentsOf: saves.map { $0.type = .savingThrow; return $0 })
        }
        if let skills = try container.decodeIfPresent([Proficiency].self, forKey: .skills) {
            allProficiencies.append(contentsOf: skills.map { $0.type = .skill; return $0 })
        }
        
        proficiencies = allProficiencies
        
        // Decode each category and map to ActionTraits with appropriate ActionType; GROK 3
        var allActionTraits: [ActionTrait] = []
        if let traits = try container.decodeIfPresent([ActionTrait].self, forKey: .traits) {
            allActionTraits.append(contentsOf: traits.map { $0.type = .trait; return $0 })
        }
        if let actions = try container.decodeIfPresent([ActionTrait].self, forKey: .actions) {
            allActionTraits.append(contentsOf: actions.map { $0.type = .action; return $0 })
        }
        if let bonusActions = try container.decodeIfPresent([ActionTrait].self, forKey: .bonusActions) {
            allActionTraits.append(contentsOf: bonusActions.map { $0.type = .bonusAction; return $0 })
        }
        if let reactions = try container.decodeIfPresent([ActionTrait].self, forKey: .reactions) {
            allActionTraits.append(contentsOf: reactions.map { $0.type = .reaction; return $0 })
        }
        if let legendaryActions = try container.decodeIfPresent([ActionTrait].self, forKey: .legendaryActions) {
            allActionTraits.append(contentsOf: legendaryActions.map { $0.type = .legendary; return $0 })
        }
        if let mythicActions = try container.decodeIfPresent([ActionTrait].self, forKey: .mythicActions) {
            allActionTraits.append(contentsOf: mythicActions.map { $0.type = .mythic; return $0 })
        }
        
        self.actionTraits = allActionTraits
    }
    
    // MARK: - Computed Properties
    
    /// Primary movement speed (assumes first speed value is primary)
    var mainSpeed: String {
        return speed?.first ?? "0 ft."
    }
    
    /// Checks if the monster has Mythic Actions
    var isMythic: Bool {
        return !mythicActions.isEmpty
    }
    
// Helper properties to filter actionTraits by type
    var saves: [Proficiency] {
        proficiencies.filter { $0.type == .savingThrow }
    }
    var skills: [Proficiency] {
        proficiencies.filter { $0.type == .skill }
    }
    
    var traits: [ActionTrait] {
        actionTraits.filter { $0.type == .trait }
    }
    var actions: [ActionTrait] {
        actionTraits.filter { $0.type == .action }
    }
    var bonusActions: [ActionTrait] {
        actionTraits.filter { $0.type == .bonusAction }
    }
    var reactions: [ActionTrait] {
        actionTraits.filter { $0.type == .reaction }
    }
    var legendaryActions: [ActionTrait] {
        actionTraits.filter { $0.type == .legendary }
    }
    var mythicActions: [ActionTrait] {
        actionTraits.filter { $0.type == .mythic }
    }
    
    var challengeRating: Double {
        switch challenge {
            case "1/8": return 1 / 8
            case "1/4": return 1 / 4
            case "1/2": return 1 / 2
            case let value where Double(value) != nil: return Double(value)!
            default: return 0.0 // Log this as an error if unexpected
        }
    }
}

extension Monster_A5e: Monstrous {
    /// Estimated Average Damage Per Round
    var averageDamagePerRound: Int {
        let actionDamage = actions.reduce(0) { total, action in
            total + DamageHelper.parseDamage(from: action.content)
        }
        let legendaryDamage = legendaryActions.reduce(0) { total, action in
            total + DamageHelper.parseDamage(from: action.content)
        }
        return actionDamage + legendaryDamage
    }
    
    /// Checks if the monster has Legendary Actions
    var isLegendary: Bool {
        !legendaryActions.isEmpty
    }
}

//extension Monster_A5e: ViewDataSource {
//    static func listViewContent (_ listItem: Any) -> AnyView {
//        let monster = listItem as! Monster_A5e
//        
//        return AnyView(
//            NavigationLink(destination: MonsterA5eDetailView(monster: monster)) {
//                HStack {
//                    if let image = monster.imageURL, image.count > 0 {
//                        Image(image)
//                            .frame(width: 50, height: 50)
//                            .clipShape(Circle())
//                    }
//                    else {
//                        Circle()
//                            .foregroundStyle(.clear)
//                            .frame(width: 50, height: 50)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text(monster.name).font(.headline)
//                        Text("Challenge: \(monster.challenge)").font(.subheadline).foregroundStyle(.gray)
//                    }
//                    Spacer()
//                    if monster.isLegendary {
//                        Image(systemName: "star.fill").foregroundStyle(.yellow)
//                    }
//                }
//            }
//        )
//    }
//}

//extension Monster_A5e: MonstrousDTO {
//    func toSourceId() -> String { sourceId }
//    func toSourceKeyRawValue() -> String { SourceKey.a5e.rawValue }
//    func toName() -> String {  name }
//    func toLink() -> String { link }
//    func toVersion() -> String { version }
//    func toDesc() -> String? { desc }
//    func toType() -> String { monsterType }
//    func toSubtype() -> String? { nil }
//    func toSize() -> String? { nil }
//    func toAlignment() -> String? { nil }
//    func toHitPoints() -> Int { hp?.value ?? 0 }
//    func toHitDice() -> String? { hp?.notes }
//    func toArmorClass() -> Int { ac?.value ?? 0 }
//    func toArmorType() -> String? { ac?.notes }
//    func toInitiativeModifier() -> Int { initiativeModifier }
//    
//    func toSpeed() -> [String] { if let speed { return speed } else { return [] }}
//    func toAbilities() -> Abilities { abilities ?? Abilities() }
//    func toDamageVulnerabilities() -> [String]? {
//        if let damageVulnerabilities, damageVulnerabilities.count > 0 { return damageVulnerabilities } else { return nil }
//    }
//    func toDamageResistances() -> [String]? {
//        if let damageResistances, damageResistances.count > 0 { return damageResistances } else { return nil }
//    }
//    func toDamageImmunities() -> [String]? {
//        if let damageImmunities, damageImmunities.count > 0 { return damageImmunities } else { return nil }
//    }
//    func toConditionImmunities() -> [String]? {
//        if let conditionImmunities, conditionImmunities.count > 0 { return conditionImmunities } else { return nil }
//    }
//    func toSenses() -> [String] { if let senses { return senses } else { return [] } }
//    func toLanguages() -> String { languages?.joined(separator: ", ") ?? "" }
//    func toSaves() -> [Proficiency]? { saves }
//    func toSkills() -> [Proficiency]? { skills }
//    func toChallengeRating() -> Double {
//        switch challenge {
//            case "1/8": return 1 / 8
//            case "1/4": return 1 / 4
//            case "1/2": return 1 / 2
//            case let value where Double(value) != nil: return Double(value)!
//            default: return 0.0 // Log this as an error if unexpected
//        }
//    }
//    func toProficiencyBonus() -> Int? { nil }
//    func toTraits() -> [ActionTrait]?  {
////        if let traits, traits.count > 0 { return traits } else { return nil }
//        traits.isEmpty ? nil : traits
//    }
//    func toActions() -> [ActionTrait]? {
////        if let actions, actions.count > 0 { return actions } else { return nil }
//        actions.isEmpty ? nil : actions
//    }
//    func toBonusActions() -> [ActionTrait]? {
////        if let bonusActions, bonusActions.count > 0 { return bonusActions } else { return nil }
//        bonusActions.isEmpty ? nil : bonusActions
//    }
//    func toReactions() -> [ActionTrait]? {
////        if let reactions, reactions.count > 0 { return reactions } else { return nil }
//        reactions.isEmpty ? nil : reactions
//    }
//    func toLegendaryActions() -> [ActionTrait]? {
////        if let legendaryActions, legendaryActions.count > 0 { return legendaryActions } else { return nil }
//        legendaryActions.isEmpty ? nil : legendaryActions
//    }
//    func toMythicActions() -> [ActionTrait]? {
////        if let mythicActions, mythicActions.count > 0 { return mythicActions } else { return nil }
//        mythicActions.isEmpty ? nil : mythicActions
//    }
//    func toCombat() -> String? { combat }
//    func toVariants() -> [MonsterVariant]? { variants }
//}
