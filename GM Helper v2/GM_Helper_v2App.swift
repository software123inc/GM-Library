//
//  GM_Helper_v2App.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import SwiftUI
import SwiftData

@main
struct GM_Helper_v2App: App {
    var sharedModelContainer: ModelContainer = {
        let modelConfiguration = ModelConfiguration(
            schema: AppCommon.shared.schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: AppCommon.shared.schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
