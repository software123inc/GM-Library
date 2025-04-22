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
                    if monster.xp == nil {
                        Text("CHALLENGE " + monster.challengeText)
                    }
                }
                HStack {
                    if let size = monster.size {
                        HStack(spacing: 0) {
                            Text("\(size) \(monster.type)")
                            if let subtype = monster.subtype {
                                Text(" (\(subtype))")
                            }
                            if let alignment = monster.alignment {
                                Text(", \(alignment.localizedLowercase)")
                            }
                        }.italic()
                    }
                    else {
                        Text("\(monster.isLegendary ? "LEGENDARY " : "")" + monster.type.localizedUppercase)
                    }
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
