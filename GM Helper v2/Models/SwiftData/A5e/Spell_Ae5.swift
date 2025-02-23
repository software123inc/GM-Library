//
//  Spell.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//


import SwiftUI
import SwiftData

@Model
class Spell_Ae5: Decodable, Nameable {
    #Index<Spell_Ae5>([\.id], [\.name], [\.originalId], [\.level])
    
    var id:UUID
    var originalId: String = ""
    var name: String = ""
    var path: String = ""
    var link: String = ""
    var version: String = ""
    var source: String = ""
    var castingTime: String = ""
    var components: String = ""
    var desc: String = ""
    var duration: String = ""
    var level: Int = 0
    var range: String = ""
    var ritual: Bool = false
    var school: String = ""
    var classes: [String] = []
    var filterDimensions: FilterDimensions_A5e?

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

//extension Spell_Ae5:ViewDataSource {
//    static func listViewContent (_ listItem: Any) -> AnyView {
//        let spell = listItem as! Spell_Ae5
//        return AnyView(
//            NavigationLink(destination: SpellA5eDetailView(spell: spell)) {
//                VStack(alignment: .leading) {
//                    Text(spell.name)
//                        .font(.headline)
//                    Text("Level \(spell.level) - \(spell.school)")
//                        .font(.subheadline)
//                        .foregroundStyle(.gray)
//                }
//            }
//        )
//    }
//}
