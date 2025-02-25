//
//  GM_Helper_v2App.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import SwiftUI
import SwiftData
import SDWebImage
import SDWebImageSwiftUI
//import SDWebImage

@main
struct GM_Helper_v2App: App {
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
        SDWebImageDownloader.shared.setValue("image/webp,image/*,*/*;q=0.8", forHTTPHeaderField:"Accept")
    }
    
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
            SidebarHomeView()
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) { _, newScenePhase in
            switch newScenePhase {
                case .active:
                    doAppIsActiveTasks()
                case .inactive:
                    doAppIsInactiveTasks()
                case .background:
                    doEnterBackgroundTasks()
                @unknown default:
                    debugPrint("App enteringing unhandled phase.")
            }
        }
    }
}

extension GM_Helper_v2App {
    private func saveDefaultData() {
        do {
            debugPrint("Doing Save")
            try sharedModelContainer.mainContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func asyncImportJson<T:SwiftData.PersistentModel>(value: T.Type, resource:String, _ status: inout Bool) async where T:Decodable {
        debugPrint("Importing from '\(resource)'.")
        let items = await JsonDataLoader.loadJson(from: resource) as [T]
        
        do {
            let context = sharedModelContainer.mainContext
            
            for item in items {
                context.insert(item)
            }
            
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        status.toggle()
    }
}

extension GM_Helper_v2App {
    // The scene is in the foreground and interactive.
    private func doAppIsActiveTasks() {
        debugPrint("App is active.")
                
        debugPrint("Should import monsters A5e: \(SyncManager.userPrefs.importMonstersA5e)")
        debugPrint("Should import spells A5e: \(SyncManager.userPrefs.importSpellsA5e)")
        debugPrint("Should import monsters WoTC: \(SyncManager.userPrefs.importMonstersWoTC)")
        debugPrint("Should import spells WoTC: \(SyncManager.userPrefs.importSpellsWoTC)")
        
        if SyncManager.userPrefs.importMonstersA5e {
            Task {
                await asyncImportJson(
                    value:Monster_A5e.self,
                    resource: JsonResourceKey.monstersA5e.rawValue,
                    &SyncManager.userPrefs.importMonstersA5e
                )
                
                insertNormalizedMonsters(value: Monster_A5e.self)
                
                saveDefaultData();
            }
        }
        
        if SyncManager.userPrefs.importSpellsA5e {
            Task {
                await asyncImportJson(
                    value:Spell_Ae5.self,
                    resource: JsonResourceKey.spellsA5e.rawValue,
                    &SyncManager.userPrefs.importSpellsA5e
                )
                
                saveDefaultData();
            }
        }
        
        if SyncManager.userPrefs.importMonstersWoTC {
            Task {
                await asyncImportJson(
                    value:Monster_WoTC.self,
                    resource: JsonResourceKey.monstersWoTC.rawValue,
                    &SyncManager.userPrefs.importMonstersWoTC
                )
                
                insertNormalizedMonsters(value: Monster_WoTC.self)
                
                saveDefaultData();
            }
        }
        
        if SyncManager.userPrefs.importSpellsWoTC {
            Task {
                await asyncImportJson(
                    value:Spell_WoTC.self,
                    resource: JsonResourceKey.spellsWoTC.rawValue,
                    &SyncManager.userPrefs.importSpellsWoTC
                )
                
                saveDefaultData();
            }
        }
    }
    
    private func insertNormalizedMonsters<T:SwiftData.PersistentModel>(value: T.Type) where T:MonstrousDTO, T:Nameable {
        let mainContext = sharedModelContainer.mainContext
        let fetcher = FetchDescriptor<T>(sortBy: [.init(\T.name)])
        if let monsters = try? mainContext.fetch(fetcher) {
            for monster in monsters {
                var m:Monster?
                switch T.self {
                    case is Monster_A5e.Type:
                        let mm = monster as! Monster_A5e
                        m = monster.toMonster(monsterA5e: mm)
                    case is Monster_WoTC.Type:
                        let mm = monster as! Monster_WoTC
                        m = monster.toMonster(monsterWoTC: mm)
                    default: break
                        
                }
//                let m = monster.toMonster()
                if let m {
                    mainContext.insert(m)
                }
            }
            
            debugPrint("Saved normalized monsters from: \(T.self)")
        }
    }
    
    // The scene is in the foreground but should pause its work.
    private func doAppIsInactiveTasks() {
        debugPrint("App is inactive.")
        saveDefaultData()
    }
    
    // The scene isn’t currently visible in the UI.
    private func doEnterBackgroundTasks() {
        debugPrint("App is entering the background..")
        saveDefaultData()
    }
}
