//
//  ImageSource.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/25/25.
//

import SwiftUI
import SDWebImageSwiftUI

protocol ImageSource: Nameable {
    var imageName: String { get }
    var mmImageUrl: URL? { get }
    var mmImageTokenUrl: URL? { get }
    func mmImage() -> AnyView
    func mmImageToken() -> AnyView
}

extension ImageSource {
    var imageName: String {
        self.name
    }
    
    var mmImageUrl: URL? { get {
        URL(string: "https://5e.tools/img/bestiary/MM/\(self.imageName.replacingOccurrences(of: " ", with: "%20")).webp")
    } }
    
    var mmImageTokenUrl: URL? { get {
        URL(string: "https://5e.tools/img/bestiary/tokens/MM/\(self.imageName.replacingOccurrences(of: " ", with: "%20")).webp")
    } }
    
    func mmImageToken() -> AnyView {
        AnyView(
            WebImage(
                url: self.mmImageTokenUrl,
                content: { image in
                    image
                },
                placeholder: {
                    // if image not found
                    Circle()
                        .foregroundStyle(.gray)
                })
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .frame(width: 45, height: 45)
            .clipped()
        )
    }
    
    func mmImage() -> AnyView {
        AnyView(
            WebImage(
                url: self.mmImageUrl,
                content: { image in
                    image
                },
                placeholder: {
                    // if image not found
                    EmptyView()
                })
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            //            .frame(width: 45, height: 45)
                .clipped()
        )
    }
}
