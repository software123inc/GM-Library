//
//  Monster.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//
//  https://useyourloaf.com/blog/swiftdata-indexes/
// Single collection for all traits/actions; GROK 3

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

// MARK: - Monster Model

@Model
class Monster_A5e: Decodable, Nameable {
    #Index<Monster_A5e>([\.id], [\.sourceId], [\.name], [\.monsterType], [\.challenge])
    
    var id: UUID = UUID()
    var sourceId: String = ""
    var name: String = ""
    var path: String = ""
    var link: String = ""
    var version: String = ""
    var source: String = ""
    var monsterType: String = ""
    var size: String?
    var xp: Int?
    var initiativeModifier: Int = 0
    var speed: [String]?
    var damageVulnerabilities: [String]? = []
    var damageResistances: [String]? = []
    var damageImmunities: [String]? = []
    var conditionImmunities: [String]? = []
    var senses: [String]? = []
    var languages: [String]? = []
    var challenge: String = ""
    var desc: String?
    var player: String?
    var imageURL: String?
    var combat: String?
    
    @Relationship(deleteRule: .cascade, inverse: \Abilities.monsterA5e) var abilities: Abilities?
    @Relationship(deleteRule: .cascade, inverse: \AC_A5e.monsterA5e) var ac: AC_A5e?
    @Relationship(deleteRule: .cascade, inverse: \ActionTrait.monsterA5e) private var actionTraits: [ActionTrait]? = []
    @Relationship(deleteRule: .cascade, inverse: \FilterDimensions_A5e.monsterA5e) var filterDimensions: FilterDimensions_A5e?
    @Relationship(deleteRule: .cascade, inverse: \HP_A5e.monsterA5e) var hp: HP_A5e?
    @Relationship(deleteRule: .cascade, inverse: \Monster.monsterA5e) var normalizedMonster: Monster?
    @Relationship(deleteRule: .cascade, inverse: \Proficiency.monsterA5e) private var proficiencies: [Proficiency]? = []    
    var monsterVariant:MonsterVariant?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "Id"
        case name = "Name"
        case path = "Path"
        case link = "Link"
        case filterDimensions = "FilterDimensions"
        case version = "Version"
        case source = "Source"
        case monsterType = "Type"
        case size = "Size"
        case xp = "XP"
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
        self.size = try container.decodeIfPresent(String.self, forKey: .size)
        self.xp = try container.decodeIfPresent(Int.self, forKey: .xp)
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
        proficiencies?.filter { $0.type == .savingThrow } ?? []
    }
    var skills: [Proficiency] {
        proficiencies?.filter { $0.type == .skill } ?? []
    }
    
    var traits: [ActionTrait] {
        actionTraits?.filter { $0.type == .trait } ?? []
    }
    var actions: [ActionTrait] {
        actionTraits?.filter { $0.type == .action } ?? []
    }
    var bonusActions: [ActionTrait] {
        actionTraits?.filter { $0.type == .bonusAction } ?? []
    }
    var reactions: [ActionTrait] {
        actionTraits?.filter { $0.type == .reaction } ?? []
    }
    var legendaryActions: [ActionTrait] {
        actionTraits?.filter { $0.type == .legendary } ?? []
    }
    var mythicActions: [ActionTrait] {
        actionTraits?.filter { $0.type == .mythic } ?? []
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

extension Monster_A5e: ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme) -> AnyView {
        guard let monster = (anyObject as? Monster_A5e)?.normalizedMonster else {
            return AnyView(EmptyView() )
        }
        
        return Monster.listItemViewContent(monster, colorScheme)
    }
    
    static func listItemFooterViewContent (_ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(
            HStack(spacing: 4) {
                Image(systemName: "l.circle").foregroundStyle(.a5EGreen)
                Text("= Legendary")
                Spacer()
            }.padding()
        )
    }
}

extension Monster_A5e: MonstrousDTO {
    func toSourceId() -> String { sourceId }
    func toSourceKeyRawValue() -> String { SourceKey.a5e.rawValue }
    func toName() -> String {  name }
    func toLink() -> String { link }
    func toVersion() -> String { version }
    func toDesc() -> String? { desc }
    func toType() -> String { monsterType }
    func toSubtype() -> String? { nil }
    func toSize() -> String? { size }
    func toAlignment() -> String? { nil }
    func toHitPoints() -> Int { hp?.value ?? 0 }
    func toHitDice() -> String? { hp?.notes }
    func toArmorClass() -> Int { ac?.value ?? 0 }
    func toArmorType() -> String? { ac?.notes }
    func toInitiativeModifier() -> Int { initiativeModifier }
    func toSpeed() -> [String] { if let speed { return speed } else { return [] }}
    func toAbilities() -> Abilities { abilities ?? Abilities() }
    func toDamageVulnerabilities() -> [String]? { damageVulnerabilities?.isEmpty ?? true ? nil : damageVulnerabilities }
    func toDamageResistances() -> [String]? {  damageResistances?.isEmpty ?? true ? nil : damageResistances }
    func toDamageImmunities() -> [String]? { damageImmunities?.isEmpty ?? true ? nil : damageImmunities }
    func toConditionImmunities() -> [String]? { conditionImmunities?.isEmpty ?? true ? nil : conditionImmunities }
    func toSenses() -> [String] { if let senses { return senses } else { return [] } }
    func toLanguages() -> String { languages?.joined(separator: ", ") ?? "" }
    func toSaves() -> [Proficiency]? {
        saves
    }
    func toSkills() -> [Proficiency]? { skills }
    func toChallengeRating() -> Double { challengeRating }
    func toProficiencyBonus() -> Int? { nil }
    func toTraits() -> [ActionTrait]?  { traits.isEmpty ? nil : traits }
    func toActions() -> [ActionTrait]? { actions.isEmpty ? nil : actions }
    func toBonusActions() -> [ActionTrait]? { bonusActions.isEmpty ? nil : bonusActions }
    func toReactions() -> [ActionTrait]? { reactions.isEmpty ? nil : reactions }
    func toLegendaryActions() -> [ActionTrait]? { legendaryActions.isEmpty ? nil : legendaryActions }
    func toMythicActions() -> [ActionTrait]? { mythicActions.isEmpty ? nil : mythicActions }
    func toCombat() -> String? { combat }
    func toXP() -> Int? { xp }
}

extension Monster_A5e: ImageSource {
    var imageName: String {
        guard let imageURL = self.imageURL, !imageURL.isEmpty else { return "MM/" + self.name }
        
        return imageURL
    }
}
