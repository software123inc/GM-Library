//
//  SpellHeaderView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/27/25.
//

import SwiftUI

struct SpellHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    var spell:Spell
    
    var body: some View {
        VStack {
            HStack {
                Text(spell.name)
                    .font(.custom("DIN Condensed", size: 48))
                    .foregroundStyle(.a5EGreen)
                Spacer()
            }
            HStack {
                Text("\(spell.level.ordinal)-level (\(spell.schoolCleaned.localizedLowercase))")
                    .italic()
                Spacer()
            }
        }
        .foregroundStyle(Color.a5EGreen)
    }
}
