//
//  SpellWoTCDetailView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import SwiftUI

struct SpellWoTCDetailView: View {
    let spell: Spell_WoTC

    var body: some View {
        ScrollView {
            let classes = spell.classes
            VStack(alignment: .leading, spacing: 10) {
                Text("Level \(spell.level) - \(spell.school?.name ?? "")")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                if !classes.isEmpty {
                    Text("Classes: \(classes.map({$0.name ?? ""}).joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("Casting Time: \(spell.casting_time)")
                    .font(.subheadline)

                Text("Range: \(spell.range)")
                    .font(.subheadline)

                Text("Duration: \(spell.duration)")
                    .font(.subheadline)

                Text("Components: \(spell.components)")
                    .font(.subheadline)

                Divider()
                
                Text(spell.desc.joined(separator: "\n"))
                    .font(.body)
                    .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle(spell.name)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        SpellWoTCDetailView(
            spell: PreviewData
                .loadJSON(
                    forResource: JsonResourceKey.spellsWoTC.rawValue
                ).first! as Spell_WoTC
        )
    }
}
