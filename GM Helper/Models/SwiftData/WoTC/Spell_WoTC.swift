//
//  Spell_WoTC.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import SwiftUI
import SwiftData

@Model
class Spell_WoTC: Decodable, Nameable {
    #Index<Spell_WoTC>([\.id], [\.originalId], [\.name], [\.level])
    var id = UUID()
    var originalId: String = ""
    var source: String = "WoTC SRD 2014"
    var name: String = ""
    var desc: [String] = []
    var higher_level: [String]? // part of description in A5e
    var range: String = ""
    var level: Int = 0
    var ritual:Bool = false
    var casting_time: String = ""
    var duration: String = ""
    var concentration:Bool = false // Part of duration in A5e
    var components: [String] = []
    var material: String? // part of Components in A5e
    var attack_type: String? // covered in desc
    
    var url: String = ""
    
    @Relationship(deleteRule: .cascade, inverse: \AreaOfEffect.spellWoTC) var area_of_effect: AreaOfEffect?
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.spellWoTC) private var classData: [URL_WoTC]? = []
    @Relationship(deleteRule: .cascade, inverse: \SpellDamage.spellWoTC) var damage: SpellDamage?
    @Relationship(deleteRule: .cascade, inverse: \SpellDC.spellWoTC) var dc:SpellDC?
    @Relationship(deleteRule: .cascade, inverse: \SpellEffectAtSlotLevel.spellWoTC) var heal_at_slot_level:SpellEffectAtSlotLevel?
    @Relationship(deleteRule: .cascade, inverse: \Spell.spellWoTC) var normalizedSpell: Spell?
    @Relationship(deleteRule: .cascade, inverse: \URL_WoTC.spellSchool) var school: URL_WoTC?
    
    enum CodingKeys: String, CodingKey {
        case originalId = "index"
        case name
        case desc
        case higher_level
        case range
        case components
        case material
        case ritual
        case duration
        case concentration
        case casting_time
        case level
        case heal_at_slot_level
        case attack_type
        case damage
        case dc
        case area_of_effect
        case school
        case classes
        case subclasses
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.originalId = try container.decode(String.self, forKey: .originalId)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode([String].self, forKey: .desc)
        self.higher_level = try container.decodeIfPresent([String].self, forKey: .higher_level)
        self.range = try container.decode(String.self, forKey: .range)
        self.components = try container.decode([String].self, forKey: .components)
        self.material = try container.decodeIfPresent(String.self, forKey: .material)
        self.ritual = try container.decode(Bool.self, forKey: .ritual)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.concentration = try container.decode(Bool.self, forKey: .concentration)
        self.casting_time = try container.decode(String.self, forKey: .casting_time)
        self.level = try container.decode(Int.self, forKey: .level)
        self.heal_at_slot_level = try container.decodeIfPresent( SpellEffectAtSlotLevel.self, forKey: .heal_at_slot_level )
        self.attack_type = try container.decodeIfPresent(String.self, forKey: .attack_type)
        self.damage = try container.decodeIfPresent(SpellDamage.self, forKey: .damage)
        self.dc = try container.decodeIfPresent(SpellDC.self, forKey: .dc)
        self.area_of_effect = try container.decodeIfPresent(AreaOfEffect.self, forKey: .area_of_effect)
        self.school = try container.decodeIfPresent(URL_WoTC.self, forKey: .school)
        self.url = try container.decode(String.self, forKey: .url)
        
        var allUrls: [URL_WoTC] = []
        if let classes = try container.decodeIfPresent([URL_WoTC].self, forKey: .classes) {
            allUrls.append(contentsOf: classes.map { $0.type = .characterClass; return $0 })
        }
        if let subclasses = try container.decodeIfPresent([URL_WoTC].self, forKey: .subclasses) {
            allUrls.append(contentsOf: subclasses.map { $0.type = .characterSubclass; return $0; })
        }
        
        classData = allUrls
    }
    
    // Helper properties to filter actionTraits by type
    var classes: [URL_WoTC] {
        classData?.filter { $0.type == .characterClass } ?? []
    }
    var subClasses: [URL_WoTC] {
        classData?.filter { $0.type == .characterSubclass } ?? []
    }
}

extension Spell_WoTC: ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        guard let spell = (anyObject as? Spell_WoTC)?.normalizedSpell else { return AnyView(EmptyView() )}
        
        return Spell.listItemViewContent(spell, colorScheme)
    }
    
    static func listItemFooterViewContent (_ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(
            HStack(spacing: 4) {
                Image(systemName: "c.circle").foregroundStyle(.a5EGreen)
                Text("= Concentration")
                Image(systemName: "r.circle").foregroundStyle(.a5EGreen)
                Text("= Reaction")
                Spacer()
            }.padding()
        )
    }
}

extension Spell_WoTC:SpellDTO {
    func toSourceId() -> String { originalId }
    func toSourceKeyRawValue() -> String { SourceKey.wotc.rawValue }
    func toSource() -> String { source }
    func toName() -> String { name }
    func toLink() -> String { url }
    func toDesc() -> String { desc.joined(separator: "\n") }
    func toRange() -> String { range }
    func toLevel() -> Int { level }
    func toRitual() -> Bool { ritual }
    func toCastingTime() -> String { casting_time }
    func toDuration() -> String { duration }
    func toConcentration() -> Bool { concentration }
    func toSchool() -> String {
        guard let schoolName = self.school?.name else { return "" }
        
        return schoolName
    }
    func toClasses() -> [String] {
        classes.compactMap( { $0.name } )
    }
    func toComponents() -> String { components.joined(separator: ", ") }
}
