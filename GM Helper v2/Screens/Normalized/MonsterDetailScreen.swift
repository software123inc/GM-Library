//
//  MonsterDetailScreen.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MonsterDetailScreen: View {
    @Environment(\.colorScheme) var colorScheme
    var monster: Monster
    
    var body: some View {
        ScrollView {
            MonsterDetailHeaderView(monster: monster)
            MonsterImageView(monster: monster)
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

struct MonsterImageView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isExpanded: Bool = false
    
    var monster: Monster
        
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            monster.mmImage()
        }
        label: {
            Text("Portrait")
                .font(.headline)
                .italic()
                .foregroundStyle(colorScheme == .dark ? .white : .a5EGreen)
        }
        .tint(colorScheme == .dark ? .white : .a5EGreen)
    }
}


#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterDetailScreen(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersWoTC.rawValue
            ).first! as Monster_WoTC).toMonster()
        )
    }
}
