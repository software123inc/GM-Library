//
//  PersistentModelListView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//
//  https://stackoverflow.com/questions/58759987/how-do-you-check-if-swiftui-is-in-preview-mode/
//  https://medium.com/onlyswiftui/fetch-swiftdata-programmatically-f9639f14e6f8
//  https://stackoverflow.com/questions/56517904/how-do-i-modify-the-background-color-of-a-list-in-swiftui

import SwiftUI
import SwiftData

struct PersistentModelListView<T:PersistentModel>: View where T:Nameable, T:ViewDataSource {
    @Environment(\.colorScheme) var colorScheme
    var navigationTitle:String
    @Query private var listItems: [T]
    @State private var search: String = ""
    @State private var selectedItem: T? = nil
    
    init(navigationTitle:String = "") {
        if ProcessInfo.processInfo.environment[EnvironmentKey.xcodePreviewMode.rawValue] != "1" {
            let descriptor = FetchDescriptor<T>(predicate: nil, sortBy: [.init(\.name, order: .forward)])
            
            self._listItems = Query(descriptor)
        }
        else {
            var descriptor:FetchDescriptor<T>?
            
            switch T.self {
                case is Monster.Type:
                    descriptor = FetchDescriptor<Monster>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward), .init(\.sourceKeyRawValue, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Spell.Type:
                    descriptor = FetchDescriptor<Spell>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward), .init(\.sourceKeyRawValue, order: .forward) ]
                    ) as? FetchDescriptor<T>
                case is Monster_A5e.Type:
                    descriptor = FetchDescriptor<Monster_A5e>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Monster_WoTC.Type:
                    descriptor = FetchDescriptor<Monster_WoTC>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Spell_A5e.Type:
                    descriptor = FetchDescriptor<Spell_A5e>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Spell_WoTC.Type:
                    descriptor = FetchDescriptor<Spell_WoTC>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Treasure_A5e.Type:
                    descriptor = FetchDescriptor<Treasure_A5e>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                case is Treasure_WoTC.Type:
                    descriptor = FetchDescriptor<Treasure_WoTC>(
                        predicate: nil,
                        sortBy: [.init(\.name, order: .forward)]
                    ) as? FetchDescriptor<T>
                default:
                    break
            }
            
            if let descriptor {
                self._listItems = Query(descriptor)
            }
        }
        
        self.navigationTitle = navigationTitle
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(filteredListItems, selection: $selectedItem) { item in
#if os(iOS)
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        T.listItemViewContent(item, colorScheme)
                            .listRowBackground(Color.clear) // must not applied to iPad
                    }
                    else {
                        T.listItemViewContent(item, colorScheme)
                            .background(Color.clear) // when selected, will appear .white/.gray
                    }
#else
                    T.listItemViewContent(item, colorScheme)
                        .background(Color.clear) // when selected, will appear .white/.gray
#endif
                }
                .searchable(text: $search)
                T.listItemFooterViewContent(colorScheme)
            }
            .navigationTitle(navigationTitle)
            .background(Color.buff)
            .scrollContentBackground(.hidden)
        }
    }
}

extension PersistentModelListView {
    private var filteredListItems: [T] {
        if search.isEmptyOrWhiteSpace {
            return listItems
        } else {
            return listItems.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
}

#if os(iOS)
#Preview("Norm Monster", traits: .sampleData) {
    PersistentModelListView<Monster>(navigationTitle: "Monsters")
}
//
#Preview("Norm Spells", traits: .sampleData) {
    PersistentModelListView<Spell>(navigationTitle: "Spells")
}

#Preview("Norm Treasures", traits: .sampleData) {
    PersistentModelListView<Treasure>(navigationTitle: "Treasures")
}
#endif
//
//#Preview("A5e Monster", traits: .sampleData) {
//    PersistentModelListView<Monster_A5e>(navigationTitle: "Monsters A5e")
//}
//
//#Preview("A5e Spells", traits: .sampleData) {
//    PersistentModelListView<Spell_A5e>(navigationTitle: "Spells A5e")
//}
//
//#Preview("WoTC Monster", traits: .sampleData) {
//    PersistentModelListView<Monster_WoTC>(navigationTitle: "Monsters WoTC")
//}
//
//#Preview("WoTC Spells", traits: .sampleData) {
//    PersistentModelListView<Spell_WoTC>(navigationTitle: "Spells WoTC")
//}
