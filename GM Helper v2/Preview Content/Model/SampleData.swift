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
    
    let spellsA5e = (PreviewData.loadJSON(forResource: JsonResourceKey.spellsA5e.rawValue) as [Spell_Ae5]).prefix(5)
    
    // add spells
    for spell in spellsA5e {
        container.mainContext.insert(spell)
    }
    
    do {
        try container.mainContext.save()
    }
    catch {
        fatalError("[SAMPLE DATA] Unable to save context. \(error.localizedDescription)")
    }
    
    return container
}()

