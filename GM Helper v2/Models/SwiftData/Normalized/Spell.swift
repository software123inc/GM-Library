//
//  Spell.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI
import SwiftData

@Model
class Spell: Nameable, Identifiable {
    var id: UUID = UUID()
    var sourceId: String = ""
    var sourceKeyRawValue: String = "homebrew"
    var source: String = ""
    var name: String = ""
    var link:String = ""
    var desc: String = ""
    var concentration:Bool = false
    var range: String = ""
    var level: Int = 0
    var ritual: Bool = false
    var castingTime: String = ""
    var duration: String = "" // contains "Concentration
    var school: String = ""
    var classes: [String] = []
    var components: String = ""
    
    @Relationship(deleteRule: .cascade) var spellA5e: Spell_A5e? // Single relationship
    @Relationship(deleteRule: .cascade) var spellWoTC: Spell_WoTC? // Single relationship
    
    init(
        sourceId: String = "",
        sourceKeyRawValue: String = "",
        source: String = "",
        name: String = "",
        link: String = "",
        desc: String = "",
        concentration:Bool = false,
        range: String = "",
        level: Int = 0,
        ritual: Bool = false,
        castingTime: String = "",
        duration: String = "",
        school: String,
        classes: [String] = [],
        components: String = "",
        spellA5e: Spell_A5e? = nil,
        spellWoTC: Spell_WoTC? = nil
    ) {
        self.sourceId = sourceId
        self.sourceKeyRawValue = sourceKeyRawValue
        self.source = source
        self.name = name
        self.link = link
        self.desc = desc
        self.concentration = concentration
        self.range = range
        self.level = level
        self.ritual = ritual
        self.castingTime = castingTime
        self.duration = duration
        self.school = school
        self.classes = classes
        self.components = components
        self.spellA5e = spellA5e
        self.spellWoTC = spellWoTC
    }
    
    var schoolCleaned: String {
        return school.replacingOccurrences(of: " (", with: "; ").replacingOccurrences(of: ")", with: "")
    }
}

extension Spell:ViewDataSource {
    static func listItemViewContent (_ listItem: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        let spell = listItem as! Spell
        
        return AnyView(
            NavigationLink(destination: SpellDetailScreen( spell: spell)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(spell.name + " (\(spell.sourceKeyRawValue))")
                            .font(.custom("DIN Condensed", size: 24))
                        
                        Text("Level \(spell.level) - \(spell.school)")
                            .font(.caption)
                    }
                    .foregroundStyle(colorScheme == .dark ? .black : .primary)
                    Spacer()
                    HStack {
                        if spell.concentration {
                            Image(systemName: "c.circle")
                                .foregroundStyle(.a5EGreen)
                        }
                        if spell.ritual {
                            Image(systemName: "r.circle")
                                .foregroundStyle(.a5EGreen)
                        }
                    }
                }
            }
        )
    }
}
