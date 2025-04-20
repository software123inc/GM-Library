//
//  CoffeeThreeColumnSplitView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  https://www.appcoda.com/navigationsplitview-swiftui/

import SwiftUI

struct CoffeeThreeColumnSplitView: View {
    @State private var selectedCategoryId: MenuItem.ID?
    @State private var selectedItem: MenuItem?
        private var dataModel = CoffeeEquipmenModel()
    
    var body: some View {
        NavigationSplitView {
            List(dataModel.mainMenuItems,  selection: $selectedCategoryId) { item in
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
            .listStyle(PlainListStyle())
            .navigationTitle("Sidebar")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        content: {
            Group {
                if let selectedCategoryId {
                    if let subMenuItems = dataModel.subMenuItems(for: selectedCategoryId) {
                        List(subMenuItems, selection: $selectedItem) { item in
                            NavigationLink(value: item) {
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
                        Text("Unhandled Content.")
                    }
                } else {
                    Text("Please select a sidebar item.")
                }
            }
            .navigationTitle("CONTENT")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        detail: {
            Group {
                if let selectedItem {
                    VStack() {
                        Spacer()
                        Text("\(selectedItem.name)")
                        Spacer()
                    }
                } else {
                    Text("Please select a content item.")
                }
            }
            .navigationTitle("DETAIL")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
}

#Preview() {
    CoffeeThreeColumnSplitView()
}
