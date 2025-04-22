//
//  TreasureHeaderView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 4/18/25.
//

import SwiftUI

struct TreasureHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    var treasure:Treasure
    
    var body: some View {
        VStack {
            HStack {
                Text(treasure.name)
                    .font(.custom("DIN Condensed", size: 48))
                    .foregroundStyle(.a5EGreen)
                Spacer()
            }
        }
        .foregroundStyle(Color.a5EGreen)
    }
}
