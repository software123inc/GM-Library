//
//  Spell.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import Foundation
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
}
