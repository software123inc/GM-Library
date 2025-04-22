//
//  MonsterDetailScreen.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterDetailScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    var monster: Monster
    
    var body: some View {
        ScrollView {
            Group {
                MonsterDetailHeaderView(monster: monster)
                DetailsTextView(content: monster.desc).padding([.top], 8)
                MonsterImageView(monster: monster)
                MonsterDefensesView(monster: monster)
                MonsterAbilitiesView(monster: monster)
                MonsterSavingThrowsView(monster: monster)
                MonsterSkillsView(monster: monster)
                MonsterSensesView(monster: monster)
                MonsterLanguagesView(monster: monster)
                MonsterXPView(monster: monster)
            }
            Group {
                MonsterTraitsView(monster: monster, isA5e: monster.monsterA5e == nil).padding([.top], 8)
                MonsterActionsView(monster: monster)
                MonsterBonusActionsView(monster: monster)
                MonsterReactionsView(monster: monster)
                MonsterLegendaryActionsView(monster: monster)
                MonsterMythicActionsView(monster: monster)
                MonsterNarrativeView(monster: monster)
            }
        }
        .padding()
        .background(Color.buff)
        .navigationTitle("\(monster.name) (\(monster.sourceKeyRawValue))")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview("A5e", traits: .sampleData) {
    NavigationStack {
        MonsterDetailScreen(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersA5e.rawValue
            ).first! as Monster_A5e).toMonster()
        )
    }
}

#Preview("WoTC", traits: .sampleData) {
    NavigationStack {
        MonsterDetailScreen(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersWoTC.rawValue
            ).first! as Monster_WoTC).toMonster()
        )
    }
}
