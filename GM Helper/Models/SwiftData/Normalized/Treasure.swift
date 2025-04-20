//
//  Treasure.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/18/25.
//

import SwiftUI
import SwiftData


@Model
class Treasure: Nameable, Identifiable {
    #Index<Treasure>([\.id], [\.name], [\.rarity])
    var id = UUID()
    var sourceKeyRawValue: String = "homebrew"
    var source: String = ""
    var name: String = ""
    var item_type: String = ""
    var rarity: String = ""
    var cost: String = ""
    var requires_attunement: Bool = false
    var crafting_components:String? = nil
    var desc: String = ""
    
//    @Relationship(deleteRule: .cascade)
    var treasureA5e: Treasure_A5e? = nil // Single relationship
//    @Relationship(deleteRule: .cascade)
    var treasureWoTC: Treasure_WoTC? = nil// Single relationship
    
    init(
        id: UUID = UUID(),
        sourceKeyRawValue: String,
        source: String,
        name: String,
        item_type: String,
        rarity: String,
        cost: String,
        requires_attunement: Bool,
        crafting_components:String? = nil,
        desc: String,
        treasureA5e: Treasure_A5e? = nil,
        treasureWoTC: Treasure_WoTC? = nil
    ) {
        self.id = id
        self.sourceKeyRawValue = sourceKeyRawValue
        self.source = source
        self.name = name
        self.item_type = item_type
        self.rarity = rarity
        self.cost = cost
        self.requires_attunement = requires_attunement
        self.crafting_components = crafting_components
        self.desc = desc
        self.treasureA5e = treasureA5e
        self.treasureWoTC = treasureWoTC
    }
}

extension Treasure:ViewDataSource {
    static func listItemViewContent (_ listItem: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        let treasure = listItem as! Treasure
        
        return AnyView(
            NavigationLink(destination: TreasureDetailScreen( treasure: treasure)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(treasure.name + " (\(treasure.sourceKeyRawValue))")
                            .font(.custom("DIN Condensed", size: 24))
                        
                        Text("\(treasure.item_type) - \(treasure.rarity)")
                            .font(.caption)
                    }
                    .foregroundStyle(colorScheme == .dark ? .black : .primary)
                    Spacer()
                    if treasure.requires_attunement {
                        Image(systemName: "a.circle")
                            .foregroundStyle(.a5EGreen)
                    }
                }
            }
        )
    }
}
