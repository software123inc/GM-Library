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
        if monster.desc != nil || monster.combat != nil || monster.variants?.first != nil {
            DisclosureGroup(isExpanded: $expandNarrative) {
                VStack(spacing: 8){
                    if let content = monster.combat {
                        DetailsTextView(heading: "Combat", content: content)
                    }
                    if let content = monster.variants?.first {
                        DetailsTextView(heading: "Variant: \(content.name)", content: content.desc)
                    }
                }
            } label: {
                VStack(spacing: 0) {
                    A5eHorizontalBorderView()
                    HStack {
                        Text("NARRATIVE")
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
