//
//  TreasureDetailScreen.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/18/25.
//

import SwiftUI

struct TreasureDetailScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    var treasure: Treasure
    
    var body: some View {
        ScrollView {
            TreasureHeaderView(treasure: treasure).padding([.bottom], 8)
            LabledRow(label: "Type:", value: treasure.item_type)
            LabledRow(label: "Rarity:", value: treasure.rarity).padding([.top], 8)
            LabledRow(label: "Cost:", value: treasure.cost).padding([.top], 8)
            if let crafting_components = treasure.crafting_components {
                LabledRow(label: "Cratfting Components:", value: crafting_components).padding([.top], 8)
            }
            if treasure.requires_attunement {
                LabledRow(label: "Requires Attunement:", value: "Yes").padding([.top], 8)
            }
            MarkdownText.textView(treasure.desc).padding([.top], 8)
        }
        .padding()
        .background(Color.buff)
        .navigationTitle("\(treasure.name) (\(treasure.sourceKeyRawValue))")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview("A5e", traits: .sampleData) {
    NavigationStack {
        if #available(macOS 15, *) {
            TreasureDetailScreen(treasure: (PreviewData
                .loadJSON(
                    forResource: JsonResourceKey.treasuresA5e.rawValue
                ).first! as Treasure_A5e).toTreasure()
            )
        } else {
            // Fallback on earlier versions
        }
    }
}
