//
//  SampleData.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//


import Foundation
import SwiftData
import SwiftUI

struct CoffeeSampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        coffeePreviewContainer
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var coffeeSampleData: Self = .modifier(CoffeeSampleData())
}

@MainActor
let coffeePreviewContainer: ModelContainer = {
    let schema = Schema([])
    
    let container = try! ModelContainer(
        for: schema,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    return container
}()
