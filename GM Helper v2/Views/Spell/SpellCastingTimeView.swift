//
//  SpellCastingTimeView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/27/25.
//

import SwiftUI

struct SpellCastingTimeView: View {
    @Environment(\.colorScheme) var colorScheme
    var spell:Spell
    
    var body: some View {
        if spell.ritual {
            LabledRow(label: "Casting Time:", value: "\(spell.castingTime) (ritual)")
        } else {
            LabledRow(label: "Casting Time:", value: spell.castingTime)
        }
    }
}
