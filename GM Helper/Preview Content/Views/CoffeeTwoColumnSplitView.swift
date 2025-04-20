//
//  TwoColumnSplitView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  https://www.appcoda.com/navigationsplitview-swiftui/

import SwiftUI

struct CoffeeTwoColumnSplitView: View {
    @State private var selectedCategoryId: MenuItem.ID?
    
    private var dataModel = CoffeeEquipmenModel()
    
    var body: some View {
        NavigationSplitView {
            List(dataModel.mainMenuItems, selection: $selectedCategoryId) { item in
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
            .navigationTitle("Coffee")
            
        } detail: {
            if let selectedCategoryId,
               let categoryItems = dataModel.subMenuItems(for: selectedCategoryId) {
                List(categoryItems) { item in
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
                .listStyle(.plain)
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
            } else {
                Text("Please select a category")
            }
        }
    }
}

#Preview() {
    CoffeeTwoColumnSplitView()
}
