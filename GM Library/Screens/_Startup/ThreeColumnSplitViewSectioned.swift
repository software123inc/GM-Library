//
//  ThreeColumnSplitViewSectioned.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  https://www.appcoda.com/navigationsplitview-swiftui/

import SwiftUI

struct ThreeColumnSplitViewSectioned: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedCategoryId: MenuItem.ID?
    @State private var selectedItem: MenuItem?
    private var dataModel = SplitViewSectionMenuModel()
    
    var body: some View {
        NavigationSplitView {
            List(dataModel.sectionMenuItems,  selection: $selectedCategoryId) { section in
                Section {
                    ForEach(section.menuItems) { item in
                        HStack {
                            Text(item.name)
                                .font(.system(.title3, design: .rounded))
                                .foregroundStyle(.black)
                        }.listRowBackground(Color.tanned)
                    }
                } header: {
                    Text(section.name)
                }
            }
            .background(Color.buff)
            .scrollContentBackground(.hidden)
            .navigationTitle("Resources")
#if os(iOS)
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        content: {
            Group {
                if let selectedCategoryId {
                    if let menuItem = dataModel.menuItem(for: selectedCategoryId) {
                        if let contentView = menuItem.contentView {
                            GreedyContainerView {
                                contentView
                            }
                        }
                        else if let subMenuItems = menuItem.subMenuItems {
                            List(subMenuItems, selection: $selectedItem) { item in
                                NavigationLink {
                                    if let aView = item.closureView {
                                        GreedyContainerView {
                                            aView(item.id)
                                        }
                                    }
                                    else {
                                        Text("oops 2")
                                    }
                                } label: {
                                    HStack {
                                        Image(item.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(item.name)
                                            .font(.system(.title3, design: .rounded))
                                            .bold()
                                    }
                                }
                            }
                            .listStyle(.plain)
                        }
                        else {
                            Text("Display something else here.")
                        }
                    }
                    else {
                        Text("Unhandled Content.")
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "books.vertical.fill")
                            .foregroundStyle(Color.launchScreenBackground)
                            .font(.system(size: 48))
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Item List")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        detail: {
            Group {
                if let selectedItem {
                    if let detailView = selectedItem.closureView {
                        GreedyContainerView {
                            detailView(selectedItem.id)
                        }
                    }
                    else {
                        VStack() {
                            Spacer()
                            Text("\(selectedItem.name)")
                            Spacer()
                        }
                    }
                } else {
                    ZStack {
                        Image("mystic_chamber")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.bottom)
                    }
                }
            }
            .navigationTitle("Item Details")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        .tint(colorScheme == .dark ? .white : .gray) //Color.a5EGreenTint)
    }
}

struct GreedyContainerView<Content: View>: View {
    @ViewBuilder let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(traits: .sampleData) {
    ThreeColumnSplitViewSectioned()
}
