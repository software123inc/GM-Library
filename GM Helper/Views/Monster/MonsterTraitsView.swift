//
//  MonsterTraitsView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI
import SwiftData

struct MonsterTraitsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext
    @State private var selectedSpell: Spell?
    @State private var showSpellSheet: Bool = false
    
    var monster: Monster
    var isA5e: Bool = false
        
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(monster.traits.sorted(by: { lhs, rhs -> Bool in lhs.name < rhs.name})) { row in
                row.detailView(colorScheme:colorScheme) { spellName in
                    var fetchDescriptor = FetchDescriptor<Spell>(
                        predicate: #Predicate {
                            $0.name == spellName && (($0.spellA5e == nil) == isA5e)
                        }
                    )
                    
                    fetchDescriptor.fetchLimit = 1
                    
                    do {
                        if let matchedSpell = try modelContext.fetch(fetchDescriptor).first {
                            selectedSpell = matchedSpell
                            showSpellSheet = true
                        }
                    } catch {
                        print("Error fetching spell: \(error)")
                    }
                }
            }
        }
        .sheet(isPresented: $showSpellSheet) {
            SpellDetailSheetView(showSpellSheet: $showSpellSheet, selectedSpell: $selectedSpell)
        }
    }
}

struct SpellDetailSheetView: View {
    @Binding var showSpellSheet: Bool
    @Binding var selectedSpell: Spell?
    
    var body: some View {
        if let selectedSpell {
            NavigationStack {
                SpellDetailScreen(spell: selectedSpell)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                self.showSpellSheet = false
                                self.selectedSpell = nil
                            }
                        }
                    }
            }
        }
    }
}
