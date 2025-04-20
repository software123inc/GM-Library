//
//  SpellDetailScreen.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/27/25.
//

import SwiftUI

struct SpellDetailScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    var spell: Spell
        
    var body: some View {
        ScrollView {            
            SpellHeaderView(spell: spell).padding([.bottom], 8)
            LabledRow(label: "Classes:", value: spell.classes.joined(separator: ", "))
            SpellCastingTimeView(spell: spell)
            LabledRow(label: "Range:", value: spell.range)
            LabledRow(label: "Components:", value: spell.components)
            LabledRow(label: "Duration:", value: spell.duration).padding([.bottom], 8)
            MarkdownText.textView(spell.desc)
        }
        .padding()
        .background(Color.buff)
        .navigationTitle("\(spell.name) (\(spell.sourceKeyRawValue))")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview("Spell A5e", traits: .sampleData) {
    NavigationStack {
        SpellDetailScreen(spell: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.spellsA5e.rawValue
            ).filter({ $0.name == "Alter Self" }).first! as Spell_A5e).toSpell()
        )
    }
}

#Preview("Spell A5e Concentration", traits: .sampleData) {
    NavigationStack {
        SpellDetailScreen(spell: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.spellsA5e.rawValue
            ).filter({ $0.toConcentration() }).first! as Spell_A5e).toSpell()
        )
    }
}

#Preview("Spell A5e Ritual", traits: .sampleData) {
    NavigationStack {
        SpellDetailScreen(spell: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.spellsA5e.rawValue
            ).filter({ $0.ritual }).first! as Spell_A5e).toSpell()
        )
    }
}
