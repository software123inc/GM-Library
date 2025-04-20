//
//  Image+Extensions.swift
//  GM Helper
//
//  Created by Tim W. Newton on 4/18/25.
//


import SwiftUI

#if canImport(AppKit)
public extension Image {
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}
#endif
