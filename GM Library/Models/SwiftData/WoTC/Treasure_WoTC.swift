//
//  Treasure_WoTC.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/18/25.
//

import SwiftUI
import SwiftData

@Model
class Treasure_WoTC: Decodable, Nameable {
    #Index<Treasure_WoTC>([\.id], [\.name], [\.rarity])
    var id = UUID()
    var source: String = "WoTC SRD 2014"
    var name: String = ""
    var item_type: String = ""
    var rarity: String = ""
    var cost: String = ""
    var requires_attunement: Bool = false
    var desc: String = ""
        
    @Relationship(deleteRule: .cascade, inverse: \Treasure.treasureWoTC) var normalizedTreasure: Treasure?
    
    enum CodingKeys: String, CodingKey {
        case name
        case item_type
        case rarity
        case cost
        case requires_attunement
        case desc = "description"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.item_type = try container.decode(String.self, forKey: .item_type)
        self.requires_attunement = try container.decode(Bool.self, forKey: .requires_attunement)
        self.desc = try container.decode(String.self, forKey: .desc)
        
        do {
            self.rarity = try container.decode(String.self, forKey: .rarity)
        } catch {
            let rarities = try container.decode([String].self, forKey: .rarity)
            self.rarity = rarities.joined(separator: ", ")
        }
        
        do {
            self.cost = try container.decode(String.self, forKey: .cost)
        } catch {
            let costs = try container.decode([String].self, forKey: .cost)
            self.cost = costs.joined(separator: ", ")
        }
        
    }
}

extension Treasure_WoTC: TreasureDTO {
    func toSourceKeyRawValue() -> String { SourceKey.wotc.rawValue }
    func toSource() -> String { source }
    func toName() -> String { name }
    func toItemType() -> String { self.item_type }
    func toRarity() -> String { self.rarity }
    func toCost() -> String { self.cost }
    func toRequiresAttunement() -> Bool { self.requires_attunement }
    func toCraftingComponents() -> String? { nil }
    func toDesc() -> String { desc }
}

extension Treasure_WoTC: ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        guard let content = (anyObject as? Treasure_WoTC)?.normalizedTreasure else { return AnyView(EmptyView() )}

        return Treasure.listItemViewContent(content, colorScheme)
    }
    
    static func listItemFooterViewContent (_ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(
            HStack(spacing: 4) {
                Image(systemName: "a.circle").foregroundStyle(.a5EGreen)
                Text("= Requires Attunement")
                Spacer()
            }.padding()
        )
    }
}
