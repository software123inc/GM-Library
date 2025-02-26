//
//  MonsterTraitsView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI

struct MonsterTraitsView: View {
    var monster: Monster
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(monster.traits.sorted(by: { lhs, rhs -> Bool in lhs.name < rhs.name})) { row in
                row.detailView()
            }
        }
    }
}
