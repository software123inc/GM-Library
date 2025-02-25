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
    
    let monstersA5e = (PreviewData.loadJSON(forResource: JsonResourceKey.monstersA5e.rawValue) as [Monster_A5e]).prefix(5)
    let monstersWoTC = (PreviewData.loadJSON(forResource: JsonResourceKey.monstersWoTC.rawValue) as [Monster_WoTC]).prefix(5)
    let spellsA5e = (PreviewData.loadJSON(forResource: JsonResourceKey.spellsA5e.rawValue) as [Spell_Ae5]).prefix(5)
    let spellsWoTC = (PreviewData.loadJSON(forResource: JsonResourceKey.spellsWoTC.rawValue) as [Spell_WoTC]).prefix(5)
    
    let ma:[Monster] = monstersA5e.compactMap({ m in m.toMonster(monsterA5e: m)})
    let mw:[Monster] = monstersWoTC.compactMap({ m in m.toMonster(monsterWoTC: m)})
    
    var combined: [any PersistentModel] = ma + mw + Array(monstersA5e) + Array(monstersWoTC) + Array(spellsA5e) + Array(spellsWoTC)
    
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

