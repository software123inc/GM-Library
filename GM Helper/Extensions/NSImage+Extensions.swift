//
//  NSImage+Extensions.swift
//  GM Helper
//
//  Created by Tim W. Newton on 4/18/25.
//


import SwiftUI

#if canImport(AppKit)
public typealias UIImage = NSImage

public extension NSImage {
    func jpegData(compressionQuality:CGFloat) -> Data? {
        guard let tiffData = self.tiffRepresentation,
              let imageRep = NSBitmapImageRep(data: tiffData) else {
            return nil
        }
        
        let factor = NSNumber(value: Float(compressionQuality))
        
        return imageRep.representation(using: .jpeg, properties: [.compressionFactor:factor])
    }
}
#endif
