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
    
    return container
}()

