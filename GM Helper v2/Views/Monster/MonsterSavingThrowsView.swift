//
//  MonsterSavingThrowsView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/25/25.
//

import SwiftUI

struct MonsterSavingThrowsView: View {
    var monster: Monster
    
    var body: some View {
        HStack(alignment: .top) {
            let last = monster.saves.count - 1
            Text("Saving Throws").fontWeight(.bold)
            ForEach(Array(monster.saves.enumerated()), id:\.offset) { index, save in
                save.detailView(addComma: (index < last))
            }
            Spacer()
        }
    }
}
