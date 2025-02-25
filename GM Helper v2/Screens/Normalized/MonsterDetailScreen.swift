//
//  MonsterDetailScreen.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterDetailScreen: View {
    var monster: Monster
    
    var body: some View {
        ScrollView {
            MonsterDetailHeaderView(monster: monster)
            MonsterNarrativeView(monster: monster)
            MonsterDefensesView(monster: monster)
            MonsterAbilitiesView(monster: monster)
        }
        .padding()
        .background(Color.buff)
        .navigationTitle("\(monster.name) (\(monster.sourceKeyRawValue))")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterDetailScreen(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersA5e.rawValue
            ).first! as Monster_A5e).toMonster()
        )
    }
}
