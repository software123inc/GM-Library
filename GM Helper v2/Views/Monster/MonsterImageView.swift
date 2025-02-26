//
//  MonsterImageView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/25/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MonsterImageView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isExpanded: Bool = false
    
    var monster: Monster
        
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            monster.mmImage()
        }
        label: {
            Text("Portrait")
                .font(.headline)
                .italic()
                .foregroundStyle(colorScheme == .dark ? .white : .a5EGreen)
        }
        .tint(colorScheme == .dark ? .white : .a5EGreen)
    }
}
