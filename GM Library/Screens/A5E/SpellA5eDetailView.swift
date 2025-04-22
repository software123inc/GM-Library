//
//  SpellDetailView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import SwiftUI

struct SpellA5eDetailView: View {
    let spell: Spell_A5e

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Level \(spell.level) - \(spell.school)")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                if !spell.classes.isEmpty {
                    Text("Classes: \(spell.classes.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("Casting Time: \(spell.castingTime)")
                    .font(.subheadline)

                Text("Range: \(spell.range)")
                    .font(.subheadline)

                Text("Duration: \(spell.duration)")
                    .font(.subheadline)

                Text("Components: \(spell.components)")
                    .font(.subheadline)

                if let filter = spell.filterDimensions {
                    Text("Type: \(filter.filterType)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }

                Divider()
                
                Text(spell.desc)
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
        SpellA5eDetailView(
            spell: PreviewData
                .loadJSON(
                    forResource: JsonResourceKey.spellsA5e.rawValue
                ).first! as Spell_A5e
        )
    }
}
