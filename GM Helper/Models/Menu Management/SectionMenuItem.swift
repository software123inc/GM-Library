//
//  SectionMenuItem.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import Foundation

struct SectionMenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var menuItems: [MenuItem]
}
