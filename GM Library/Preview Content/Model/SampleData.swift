//
//  SampleData.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//


import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        samplePreviewContainer
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}

@MainActor
let samplePreviewContainer: ModelContainer = {
    let container = try! ModelContainer(
        for: AppCommon.shared.schema,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    // SRD Specific Entities
    let monstersA5e  = (PreviewData.loadJSON(forResource: JsonResourceKey.monstersA5e.rawValue) as [Monster_A5e]).prefix(15)
    let monstersWoTC = (PreviewData.loadJSON(forResource: JsonResourceKey.monstersWoTC.rawValue) as [Monster_WoTC]).prefix(15)
    
    let spellsA5e  = (PreviewData.loadJSON(forResource: JsonResourceKey.spellsA5e.rawValue) as [Spell_A5e]).prefix(15)
    let spellsWoTC = (PreviewData.loadJSON(forResource: JsonResourceKey.spellsWoTC.rawValue) as [Spell_WoTC]).prefix(15)
    
    let treasuresA5e  = (PreviewData.loadJSON(forResource: JsonResourceKey.treasuresA5e.rawValue) as [Treasure_A5e]).prefix(15)
    let treasuresWoTC = (PreviewData.loadJSON(forResource: JsonResourceKey.treasuresWoTC.rawValue) as [Treasure_WoTC]).prefix(15)
    
    // Normalized Entities
    let ma:[Monster] = monstersA5e.compactMap({ m in m.toMonster(monsterA5e: m)})
    let mw:[Monster] = monstersWoTC.compactMap({ m in m.toMonster(monsterWoTC: m)})
    
    let sa:[Spell] = spellsA5e.compactMap({ s in s.toSpell(spellA5e: s)})
    let sw:[Spell] = spellsWoTC.compactMap({ s in s.toSpell(spellWoTC: s)})
    
    let ta:[Treasure] = treasuresA5e.compactMap({ t in t.toTreasure(treasureA5e: t)})
    let tw:[Treasure] = treasuresWoTC.compactMap({ t in t.toTreasure(treasureWoTC: t)})
    
    var combined: [any PersistentModel] = ma + mw + Array(monstersA5e) + Array(monstersWoTC) + Array(spellsA5e) + Array(spellsWoTC)
    combined.append(contentsOf: Array(treasuresA5e))
    combined.append(contentsOf: Array(treasuresWoTC))
    combined.append(contentsOf: sa)
    combined.append(contentsOf: sw)
    combined.append(contentsOf: ta)
    combined.append(contentsOf: tw)
    
    // add decoded JSON objects to SwiftData
    for mObj in combined {
        container.mainContext.insert(mObj)
    }
    
    do {
        try container.mainContext.save()
    }
    catch {
        fatalError("[SAMPLE DATA] Unable to save context. \(error.localizedDescription)")
    }
    
    return container
}()

