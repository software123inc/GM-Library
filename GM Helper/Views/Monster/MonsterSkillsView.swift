//
//  MonsterSkillsView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI

struct MonsterSkillsView: View {
    var monster: Monster
    
    var body: some View {
        HStack(alignment: .top) {
            let last = monster.skills.count - 1
            Text("Skills").fontWeight(.bold)
            ForEach(Array(monster.skills.enumerated()), id:\.offset) { index, skills in
                skills.detailView(addComma: (index < last))
            }
            Spacer()
        }
    }
}
