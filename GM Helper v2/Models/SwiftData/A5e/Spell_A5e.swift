//
//  Spell.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//


import SwiftUI
import SwiftData

@Model
class Spell_A5e: Decodable, Nameable {
    #Index<Spell_A5e>([\.id], [\.name], [\.originalId], [\.level])
    
    var id:UUID
    var originalId: String = ""
    var source: String = ""
    var name: String = ""
    var desc: String = ""
    var range: String = ""
    var level: Int = 0
    var ritual: Bool = false
    var castingTime: String = ""
    var duration: String = ""
    var school: String = ""
    var classes: [String] = []
    var components: String = ""
    
    var path: String = ""
    var link: String = ""
    var version: String = ""
    var filterDimensions: FilterDimensions_A5e?
    @Relationship(deleteRule: .cascade, inverse: \Spell.spellA5e) var normalizedSpell: Spell?

    enum CodingKeys: String, CodingKey {
        case originalId = "Id", name = "Name", path = "Path", link = "Link"
        case version = "Version", source = "Source", castingTime = "CastingTime"
        case components = "Components", desc = "Desc", duration = "Duration"
        case level = "Level", range = "Range", ritual = "Ritual", school = "School"
        case classes = "Classes", filterDimensions = "FilterDimensions"
    }

    required init(from decoder: Decoder) throws {
        self.id = UUID()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        originalId = try container.decode(String.self, forKey: .originalId)
        name = try container.decode(String.self, forKey: .name)
        path = try container.decode(String.self, forKey: .path)
        link = try container.decode(String.self, forKey: .link)
        version = try container.decode(String.self, forKey: .version)
        source = try container.decode(String.self, forKey: .source)
        castingTime = try container.decode(String.self, forKey: .castingTime)
        components = try container.decode(String.self, forKey: .components)
        desc = try container.decode(String.self, forKey: .desc)
        duration = try container.decode(String.self, forKey: .duration)
        level = try container.decode(Int.self, forKey: .level)
        range = try container.decode(String.self, forKey: .range)
        ritual = try container.decode(Bool.self, forKey: .ritual)
        school = try container.decode(String.self, forKey: .school)
        classes = try container.decode([String].self, forKey: .classes)
        filterDimensions = try? container
            .decodeIfPresent(
                FilterDimensions_A5e.self,
                forKey: .filterDimensions
            )
    }
}

extension Spell_A5e:ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        guard let spell = (anyObject as? Spell_A5e)?.normalizedSpell else { return AnyView(EmptyView() )}
        
        return Spell.listItemViewContent(spell, colorScheme)
    }
}

extension Spell_A5e:SpellDTO {
    func toSourceId() -> String { originalId }
    func toSourceKeyRawValue() -> String { SourceKey.a5e.rawValue }
    func toSource() -> String { source }
    func toName() -> String { name }
    func toLink() -> String { link }
    func toDesc() -> String { desc }
    func toRange() -> String { range }
    func toLevel() -> Int { level }
    func toRitual() -> Bool { ritual }
    func toCastingTime() -> String { castingTime }
    func toDuration() -> String { duration }
    func toConcentration() -> Bool { duration.contains("Concentration") }
    func toSchool() -> String { school }
    func toClasses() -> [String] { classes }
    func toComponents() -> String { components }
}
