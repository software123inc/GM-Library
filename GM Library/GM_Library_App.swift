//
//  GM_Library_App.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/23/25.
//

import CloudKit
import CoreData
import SwiftUI
import SwiftData
import SDWebImage
import SDWebImageSwiftUI

@main
struct GM_Library_App: App {
    @Environment(\.scenePhase) private var scenePhase
    
    // MARK: - SwiftData
    let sharedModelContainer: ModelContainer
    let importJsonManager: ImportJsonManager
    
    init() {
        SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
        SDWebImageDownloader.shared.setValue("image/webp,image/*,*/*;q=0.8", forHTTPHeaderField:"Accept")
        
        do {
            let modelConfiguration = ModelConfiguration(
                schema: AppCommon.shared.schema,
                isStoredInMemoryOnly: false
            )
            
            sharedModelContainer = try ModelContainer(for: AppCommon.shared.schema, configurations: [modelConfiguration])
            importJsonManager = ImportJsonManager(
                mainContext: sharedModelContainer.mainContext
            )
            
            
            handleInitialSetup()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func handleInitialSetup() {
        // https://stackoverflow.com/questions/49606831/how-to-clear-userdefaults-for-xcode-build-of-mac-app
        print("[CloudKit Test] func handleInitialSetup()")
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        let shouldUseCloudKit = UserDefaults.standard.bool(forKey: "shouldUseCloudKit")
        
        print("[INFO] Is First Launch: \(isFirstLaunch)")
        print("[INFO] Use CloudKit: \(shouldUseCloudKit)")
        
        if isFirstLaunch {
            if shouldUseCloudKit {
                let container = NSPersistentCloudKitContainer(name: "GM_Helper")
                let cloudKitSyncMonitor = CloudKitSyncMonitor(container: container)
                
                cloudKitSyncMonitor.checkCloudKitAvailability { available in
                    guard available else {
                        print("[WARNING] iCloud not available, importing without sync.")
                        importJsonManager.importJsonData()
                        return
                    }
                    
                    // Wait for CloudKit sync to launch to ensure data is up-to-date
                    cloudKitSyncMonitor.waitForInitialSync { success in
                        print("[CloudKit Test] waitForInitialSync")
                        guard success else {
                            print("[CloudKit Test] Initial sync failed! Skipping import.")
                            return
                        }
                        
                        print("[CloudKit Test] waitForInitialSync success passed.")
                        importJsonManager.importJsonData()
                    }
                }
            }
            else {
                importJsonManager.importJsonData()
            }
            
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
    }

    var body: some Scene {
        WindowGroup {
            SidebarHomeView()
        }
        .onChange(of: scenePhase) { _, newScenePhase in
            switch newScenePhase {
                case .active:
                    doAppIsActiveTasks()
                    break
                case .inactive:
                    doAppIsInactiveTasks()
                case .background:
                    doEnterBackgroundTasks()
                @unknown default:
                    debugPrint("App enteringing unhandled phase.")
            }
        }
        .modelContainer(sharedModelContainer) // https://stackoverflow.com/questions/78123311/swiftdata-crash-on-launch-in-ios-17-4-the-configuration-named-default-does-no
    }
}

extension GM_Library_App {
    private func saveDefaultData(_ entity: String = "[all]") {
        do {
            debugPrint("Doing Save: \(entity)")
            try sharedModelContainer.mainContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

extension GM_Library_App {
    // The scene is in the foreground and interactive.
    private func doAppIsActiveTasks() {
        debugPrint("App is active.")
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
