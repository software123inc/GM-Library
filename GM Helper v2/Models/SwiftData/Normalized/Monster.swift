//
//  Monster.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/22/25.
//

import SwiftUI
import SwiftData

@Model
class Monster: Nameable, ImageSource {
    #Index<Monster>([\.id], [\.sourceId], [\.name], [\.type], [\.challengeRating])
    var id = UUID()
    var sourceId: String = ""
    var sourceKeyRawValue: String = "homebrew"
    var name: String = ""
    var link:String = ""
    var version: String = "0.0.0"
    var desc: String?
    var type: String = ""
    var subtype: String?
    var size: String?
    var alignment: String?
    var hitPoints: Int = 0
    var hitDice:String?
    var armorClass: Int = 0
    var armorType:String?
    var initiativeModifier: Int = 0
    var speed: [String] = []
    var abilities: Abilities?
    var damageVulnerabilities: [String]?
    var damageResistances: [String]?
    var damageImmunities: [String]?
    var conditionImmunities: [String]?
    var senses: [String] = []
    var languages:String = ""
    @Relationship(deleteRule: .cascade, inverse: \Proficiency.monster) private var proficiencies: [Proficiency] = [] // Single collection for all proficiencies; GROK 3
    var challengeRating: Double = 0.0
    var proficiencyBonus: Int?
    @Relationship(deleteRule: .cascade, inverse: \ActionTrait.monster) private var actionTraits: [ActionTrait] = [] // Single collection for all traits/actions; GROK 3
    var combat: String?
    @Relationship(deleteRule: .cascade, inverse: \MonsterVariant.monster) var variants: [MonsterVariant]? = []
//    @Attribute(.externalStorage) var imageData: Data? = nil
    
    
    @Relationship(deleteRule: .cascade) var monsterA5e: Monster_A5e? // Single relationship
    @Relationship(deleteRule: .cascade) var monsterWoTC: Monster_WoTC? // Single relationship
    
    init(
        id: UUID = UUID(),
        sourceId: String = "",
        sourceKeyRawValue: String = "",
        name: String = "",
        link: String = "",
        version: String = "",
        desc: String? = nil,
        type: String = "",
        subtype: String? = nil,
        size: String? = nil,
        alignment: String? = nil,
        hitPoints: Int = 0,
        hitDice: String? = nil,
        armorClass: Int = 0,
        armorType: String? = nil,
        initiativeModifier: Int = 0,
        speed: [String] = [],
        abilities: Abilities? = nil,
        damageVulnerabilities: [String]? = nil,
        damageResistances: [String]? = nil,
        damageImmunities: [String]? = nil,
        conditionImmunities: [String]? = nil,
        senses: [String] = [],
        languages: String = "",
        saves: [Proficiency]? = nil,
        skills: [Proficiency]? = nil,
        challengeRating: Double = 0.0,
        proficiencyBonus: Int? = nil,
        traits: [ActionTrait]? = nil,
        actions: [ActionTrait]? = nil,
        bonusActions: [ActionTrait]? = nil,
        reactions: [ActionTrait]? = nil,
        legendaryActions: [ActionTrait]? = nil,
        mythicActions: [ActionTrait]? = nil,
        combat: String? = nil,
        variants: [MonsterVariant]? = nil,
        monsterA5e: Monster_A5e? = nil,
        monsterWoTC: Monster_WoTC? = nil
    ) {
        self.id = id
        self.sourceId = sourceId
        self.sourceKeyRawValue = sourceKeyRawValue
        self.name = name
        self.link = link
        self.version = version
        self.desc = desc
        self.type = type
        self.subtype = subtype
        self.size = size
        self.alignment = alignment
        self.hitPoints = hitPoints
        self.hitDice = hitDice
        self.armorClass = armorClass
        self.armorType = armorType
        self.initiativeModifier = initiativeModifier
        self.speed = speed
        self.abilities = abilities
        self.damageVulnerabilities = damageVulnerabilities
        self.damageResistances = damageResistances
        self.damageImmunities = damageImmunities
        self.conditionImmunities = conditionImmunities
        self.senses = senses
        self.languages = languages
        self.challengeRating = challengeRating
        self.proficiencyBonus = proficiencyBonus
        self.combat = combat
        self.variants = variants
        
        self.monsterA5e = monsterA5e
        self.monsterWoTC = monsterWoTC
        
        var allProficiencies: [Proficiency] = []
        if let saves {
            allProficiencies.append(contentsOf: saves.map { $0.type = .savingThrow; return $0 })
        }
        if let skills {
            allProficiencies.append(contentsOf: skills.map { $0.type = .skill; return $0 })
        }
        
        self.proficiencies = allProficiencies
        
        var allActionTraits: [ActionTrait] = []
        if let traits {
            allActionTraits.append(contentsOf: traits.map { $0.type = .trait; return $0 })
        }
        if let actions {
            allActionTraits.append(contentsOf: actions.map { $0.type = .action; return $0 })
        }
        if let bonusActions {
            allActionTraits.append(contentsOf: bonusActions.map { $0.type = .bonusAction; return $0 })
        }
        if let reactions {
            allActionTraits.append(contentsOf: reactions.map { $0.type = .reaction; return $0 })
        }
        if let legendaryActions {
            allActionTraits.append(contentsOf: legendaryActions.map { $0.type = .legendary; return $0 })
        }
        if let mythicActions {
            allActionTraits.append(contentsOf: mythicActions.map { $0.type = .mythic; return $0 })
        }
        self.actionTraits = allActionTraits
    }
    
    // computed values = xp from CR, CR fraction from CR (1/8, 1/4, 1/2
    // MARK: - Computed Properties
    
    /// Primary movement speed (assumes first speed value is primary)
    var mainSpeed: String {
        return speed.first ?? "0 ft."
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
    
    var challengeText: String {
        let cr:String
        
        if challengeRating == 0 {
            cr = "0"
        }
        else if challengeRating <= 0.125 {
            cr = "1/8"
        }
        else if challengeRating <= 0.25 {
            cr = "1/4"
        }
        else if challengeRating <= 0.5 {
            cr = "1/2"
        }
        else {
            cr = String(Int(challengeRating))
        }
        
        return "CHALLENGE \(cr)"
    }
    
    var allSpeeds: String {
        self.speed.joined(separator: ", ")
    }
}

extension Monster: Monstrous {
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

extension Monster: ViewDataSource {
    static func listViewContent (_ listItem: Any) -> AnyView {
        let monster = listItem as! Monster
        
        return AnyView(
            NavigationLink(destination: Text("\(monster.name), \(monster.sourceKeyRawValue)")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(monster.name).font(.headline)
                        Text("Challenge: \(monster.challengeRating)").font(.subheadline).foregroundStyle(.gray)
                    }
                    Spacer()
                    if monster.isLegendary {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                    }
                }
            }
        )
    }
}
