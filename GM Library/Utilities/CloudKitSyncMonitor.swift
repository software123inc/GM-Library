//
//  CloudKitSyncMonitor.swift
//  GM Helper
//
//  Created by Tim W. Newton on 4/19/25.
//

import CloudKit
import Combine
import CoreData
import SwiftUI

class CloudKitSyncMonitor {
    private var container: NSPersistentCloudKitContainer
    private var syncCompletionHandler: ((Bool) -> Void)?
    private var cancellables = Set<AnyCancellable>()

    init(container: NSPersistentCloudKitContainer) {
        self.container = container
        setupCloudKitSyncMonitoring()
    }

    func waitForInitialSync(completion: @escaping (Bool) -> Void) {
        syncCompletionHandler = completion
    }
    
    func checkCloudKitAvailability(completion: @escaping (Bool) -> Void) {
        CKContainer.default().accountStatus { status, error in
            if let error {
                debugPrint("[CloudKitSyncMonitor: ERROR]: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(status == .available)
            }
            
        }
    }

    private func setupCloudKitSyncMonitoring() {
        NotificationCenter.default
            .publisher(for: NSPersistentCloudKitContainer.eventChangedNotification, object: container)
            .sink { [weak self] notification in
                guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                    return
                }
                
                switch event.type {
                case .setup:
                    debugPrint("[CloudKit] setup started")
                case .import, .export:
                    if event.succeeded {
                        debugPrint("[CloudKit] import succeeded")
                        // Check if this is the initial sync
                        if event.type == .import {
                            self?.syncCompletionHandler?(true)
                            self?.syncCompletionHandler = nil // Clear handler after initial sync
                        }
                        else if event.type == .export {
                            debugPrint("[CloudKit] export succeeded.")
                        }
                    } else if let error = event.error {
                        debugPrint("[CloudKit] \(event.type.rawValue) failed: \(error)")
                        self?.syncCompletionHandler?(false)
                        self?.syncCompletionHandler = nil
                    }
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
