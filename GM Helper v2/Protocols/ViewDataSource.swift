//
//  ViewDataSource.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/21/25.
//

import SwiftUI

protocol ViewDataSource {
    static func listViewContent (_ anyObject: Any) -> AnyView
}

extension ViewDataSource {
    static func listViewContent (_ anyObject: Any) -> AnyView {
        AnyView(EmptyView())
    }
}
