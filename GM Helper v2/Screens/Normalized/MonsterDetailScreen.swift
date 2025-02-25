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
            WebImage(
                url: URL(string: "https://5e.tools/img/bestiary/MM/\(monster.name.replacingOccurrences(of: " ", with: "%20")).webp"),
                content: { image in
                    image
                },
                placeholder: {
                    // if image loading or not found
                    EmptyView()
                })
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
//            .frame(width: 100, height: 100)
            .clipped()
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
