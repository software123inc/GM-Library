//
//  MonsterDefensesView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterDefensesView: View {
    var monster: Monster
    
    var body: some View {
        VStack {
            HStack {
                Text("AC").fontWeight(.bold)
                Text(String(monster.armorClass))
                if let armorType = monster.armorType, !armorType.isEmpty {
                    Text(String(armorType))
                }
                Spacer()
            }
            HStack {
                Text("HP").fontWeight(.bold)
                Text(String(monster.hitPoints))
                if let armorType = monster.hitDice, !armorType.isEmpty {
                    Text(String(armorType))
                }
                Spacer()
            }
            HStack {
                Text("Speed").fontWeight(.bold)
                Text(monster.allSpeeds)
                Spacer()
            }
            A5eHorizontalBorderView()
        }
    }
}
