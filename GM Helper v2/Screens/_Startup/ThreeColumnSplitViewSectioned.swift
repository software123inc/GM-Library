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
            .listStyle(.insetGrouped)
            .navigationTitle("Resources")
            .navigationBarTitleDisplayMode(.inline)
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
                    ZStack {
                        Image("library_candlelight")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
//                            )
                        Text("Please select a resource from the sidebar")
                            .bold()
                            .padding()
                            .background(Color.white).opacity(0.80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
//                    Text("Please select a resource from the sidebar.")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
////                        .background(Color.buff)
//                        .backgroundImage("library_candlelight")
                }
            }
            .navigationTitle("Item List")
            .navigationBarTitleDisplayMode(.inline)
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
                    Text("Please select a item from the list.")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.buff)
                }
            }
            .navigationTitle("Item Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(colorScheme == .dark ? .white : Color.a5EGreenTint)
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
