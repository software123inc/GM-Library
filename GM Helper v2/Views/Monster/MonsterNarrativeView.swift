//
//  MonsterNarrativeView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterNarrativeView: View {
    var monster: Monster
    @State var expandNarrative: Bool = false
    
    var body: some View {
        @Environment(\.colorScheme) var colorScheme
        
        if monster.desc != nil || monster.combat != nil || monster.variants?.first != nil {
            DisclosureGroup(isExpanded: $expandNarrative) {
                VStack(spacing: 12){
                    if let desc = monster.desc {
                        A5eHorizontalBorderView()
                        DetailsTextView(content: desc)
                    }
                    if let content = monster.combat {
                        DetailsTextView(heading: "Combat", content: content)
                    }
                    if let content = monster.variants?.first {
                        DetailsTextView(heading: "Variant: \(content.name)", content: content.desc)
                    }
                }
            } label: {
                Text("Narrative")
                    .font(.headline)
                    .italic()
                    .foregroundStyle(colorScheme == .dark ? .white : .a5EGreen)
            }
            .padding([.bottom], 12)
            .tint(colorScheme == .dark ? .white : .a5EGreen)
        }
        else {
            EmptyView()
        }
    }
}
