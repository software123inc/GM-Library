import Combine

class CloudKitSyncMonitor {
    private var container: NSPersistentCloudKitContainer
    private var syncCompletionHandler: ((Bool) -> Void)?
    private var cancellables = Set<AnyCancellable>()

    init(container: NSPersistentCloudKitContainer) {
        self.container = container
        setupSyncMonitoring()
    }

    func waitForInitialSync(completion: @escaping (Bool) -> Void) {
        syncCompletionHandler = completion
    }

    private func setupSyncMonitoring() {
        NotificationCenter.default
            .publisher(for: NSPersistentCloudKitContainer.eventChangedNotification, object: container)
            .sink { [weak self] notification in
                guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                    return
                }
                
                switch event.type {
                case .setup:
                    print("CloudKit setup started")
                case .import, .export:
                    if event.succeeded {
                        print("CloudKit \(event.type.rawValue) succeeded")
                        // Check if this is the initial sync
                        if event.type == .import {
                            self?.syncCompletionHandler?(true)
                            self?.syncCompletionHandler = nil // Clear handler after initial sync
                        }
                    } else if let error = event.error {
                        print("CloudKit \(event.type.rawValue) failed: \(error)")
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