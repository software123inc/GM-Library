//
//  MonsterNarrativeView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterNarrativeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var expandNarrative: Bool = true
    var monster: Monster
    
    var body: some View {
        if let combat = monster.combat, !combat.isEmpty {
            DisclosureGroup(isExpanded: $expandNarrative) {
                DetailsTextView(heading: "Combat", content: combat)
            } label: {
                VStack(spacing: 0) {
                    A5eHorizontalBorderView()
                    HStack {
                        Text("OTHER")
                            .foregroundStyle(.a5EGreen)
                        Spacer()
                    }
                    .background(Color.tanned)
                }
            }
            .padding([.bottom], 12)
            .tint(colorScheme == .dark ? .white : .a5EGreen)
        }
        else {
            EmptyView()
        }
    }
}
