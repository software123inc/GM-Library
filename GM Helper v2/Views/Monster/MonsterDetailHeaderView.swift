//
//  MonsterDetailHeaderView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterDetailHeaderView: View {
    var monster: Monster
    
    var body: some View {
        Section {
            VStack {
                HStack {
                    Text(monster.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(monster.challengeText)
                }
                HStack {
                    if monster.isLegendary {
                        Text("LEGENDARY")
                    }
                    Text(monster.type.localizedUppercase)
                    Spacer()
                }
            }
        }
        .foregroundStyle(Color.a5EGreen)
        .padding()
        .background(Color.tanned)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.tanned, lineWidth: 4)
        )
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterDetailHeaderView(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersA5e.rawValue
            ).first! as Monster_A5e).toMonster()
        )
        .padding()
    }
}
