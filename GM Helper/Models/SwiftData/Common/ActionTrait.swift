//
//  ActionTrait.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import SwiftUI
import SwiftData

enum ActionType: String, Codable {
    case notSet
    case trait
    case action
    case bonusAction
    case reaction
    case legendary
    case mythic
}

@Model
class ActionTrait: Decodable, CustomStringConvertible {
    #Index<ActionTrait>([\.name])
    var id:UUID = UUID()
    var name: String = "Unspecified Action/Trait"
    var content: String = "No content provided."
    var sortOrder:Int = 0
//    var spells: [ActionTrait]? = nil
    var type: ActionType = ActionType.notSet // New property to categorize the action/trait
    
    @Relationship(deleteRule: .cascade, inverse: \ActionTrait.spellCastingTrait) var spells: [ActionTrait]? = []
    
    var spellCastingTrait: ActionTrait?
//    @Relationship(deleteRule: .cascade)
    var monster: Monster? // Single relationship
//    @Relationship(deleteRule: .cascade)
    var monsterA5e: Monster_A5e? // Single relationship
//    @Relationship(deleteRule: .cascade)
    var monsterVariant: MonsterVariant? // Single relationship
    
    init(name: String, content: String, sortOrder:Int = 0, spells:[ActionTrait]? = nil, type: ActionType = .notSet) {
        self.name = name
        self.content = content
        self.sortOrder = sortOrder
        self.spells = spells
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case content = "Content"
        case sortOrder = "Sort Order"
        case spells = "Spells"
        case type = "Type" // Add this to decode the type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.content = try container.decode(String.self, forKey: .content)
        self.sortOrder = try container.decodeIfPresent(Int.self, forKey: .sortOrder) ?? 0
        self.spells = try container.decodeIfPresent([ActionTrait].self, forKey: .spells)
        self.type = try container.decodeIfPresent(ActionType.self, forKey: .type) ?? .notSet
    }
    
    var description: String {
        "{name: \(name), content: \(content)}"
    }
    
    @ViewBuilder
    func detailView(addComma: Bool = false, colorScheme:ColorScheme = .light, onNameTap: ((String) -> Void)? = nil) -> some View {
        let text = "***\(name).*** \(content)"
        
        HStack {
            MarkdownText.textView(text)
            Spacer()
        }
        if let spells = spells?.sorted(by: { lhs, rhs -> Bool in lhs.sortOrder < rhs.sortOrder}), !spells.isEmpty {
            VStack {
                ForEach(spells) { spell in
                    let spellNames = spell.content.split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                        .sorted(by: {lhs, rhs -> Bool in lhs < rhs})
                    
                    VStack(alignment: .leading) {
                        MarkdownText.textView("**\(spell.name):** ")
                        ForEach(spellNames, id:\.self) { spellName in
                            Text(spellName)
                                .foregroundStyle(colorScheme == .dark ? .black : .blue) // iPad/iPhone OK
                                .underline(true)
                                .padding(.leading, 16)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            onNameTap?(spellName.smartCased())
                                        }
                                )
                        }
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}


