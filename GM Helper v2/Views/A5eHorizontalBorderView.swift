//
//  A5eBottomBorderView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct A5eHorizontalBorderView: View {
    var body: some View {
        Rectangle()
            .fill(Color.a5EGreen)
            .frame(maxWidth: .infinity, maxHeight: 1, alignment: .leading)
    }
}
