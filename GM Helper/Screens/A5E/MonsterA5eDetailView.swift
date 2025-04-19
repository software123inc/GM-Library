//
//  MonsterDetailView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import SwiftUI

struct MonsterA5eDetailView: View {
    var monster: Monster_A5e
    
    var body: some View {
        VStack(spacing: 10) {
            Text(monster.name).font(.largeTitle).bold()
            Text("HP: \(monster.hp?.value ?? 0) | AC: \(monster.ac?.value ?? 0)")
            Text("Speed: \(monster.speed?.joined(separator: ", ") ?? "")")
            Text("Average Damage: \(monster.averageDamagePerRound)")
            Text("Actions")
            ForEach(monster.actions) { action in
                Text(action.name)
            }
        }
        .padding()
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterA5eDetailView(
            monster: PreviewData
                .loadJSON(
                    forResource: JsonResourceKey.monstersA5e.rawValue
                ).first! as Monster_A5e
        )
    }
}
