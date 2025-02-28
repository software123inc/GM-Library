//
//  ViewDataSource.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import SwiftUI

protocol ViewDataSource {
    static func listItemViewContent (_ anyObject: Any) -> AnyView
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme) -> AnyView
    static func listFooterViewContent (_ colorScheme:ColorScheme) -> AnyView?
}

extension ViewDataSource {
    static func listItemViewContent (_ anyObject: Any, _ colorScheme:ColorScheme = .light) -> AnyView {
        AnyView(EmptyView())
    }
    
    static func listItemViewContent (_ anyObject: Any) -> AnyView {
        listItemViewContent(anyObject, .light)
    }
    
    static func listFooterViewContent (_ colorScheme:ColorScheme) -> AnyView? {
        nil
    }
}
