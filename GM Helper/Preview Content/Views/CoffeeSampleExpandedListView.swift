//
//  SampleExpandedListView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import SwiftUI

struct CoffeeSampleExpandedListView: View {
    private var dataModel = CoffeeEquipmenModel()
    
    var body: some View {
        List(dataModel.mainMenuItems, children: \.subMenuItems) { item in
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
#if os(iOS)
        .listStyle(InsetGroupedListStyle())
#endif
    }
}

#Preview {
    CoffeeSampleExpandedListView()
}
