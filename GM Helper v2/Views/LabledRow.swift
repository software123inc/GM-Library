//
//  LabledRow.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/27/25.
//

import SwiftUI

struct LabledRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label).bold()
            Text(value)
            Spacer()
        }
    }
}
