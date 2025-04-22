//
//  MonsterWotcDetailView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import SwiftData
import SwiftUI

struct MonsterWotcDetailView: View {
    let monster: Monster_WoTC
    
    var body: some View {
        VStack {
            Text(monster.name)
                .font(.largeTitle)
            Text("Type: \(monster.type)")
            Text("Hit Points: \(monster.hitPoints)")
            Text("Challenge Rating: \(monster.challengeRating)")
        }
        .padding()
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterWotcDetailView(
            monster: PreviewData
                .loadJSON(
                    forResource: JsonResourceKey.monstersWoTC.rawValue
                ).first! as Monster_WoTC
        )
    }
}
