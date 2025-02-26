//
//  MonsterSensesView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI

struct MonsterSensesView: View {
    var monster: Monster
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Senses").fontWeight(.bold)
            Text(monster.senses.joined(separator: ", "))
            Spacer()
        }
    }
}
