//
//  ViewDataSource.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import SwiftUI

protocol ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme) -> AnyView
    static func listItemFooterViewContent (_ colorScheme:ColorScheme) -> AnyView
}

extension ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(EmptyView())
    }
    static func listItemFooterViewContent (_ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(EmptyView())
    }
}
