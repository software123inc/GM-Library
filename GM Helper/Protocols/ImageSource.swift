//
//  ImageSource.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/25/25.
//
//  https://stackoverflow.com/questions/49458771/http-get-api-call-always-fails-nslocalizeddescription-a-server-with-the-specifi

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
        "MM/\(self.name)"
    }
    
    var mmImageUrl: URL? { get {
        URL(string: "https://5e.tools/img/bestiary/\(self.imageName.replacingOccurrences(of: " ", with: "%20")).webp")
    } }
    
    var mmImageTokenUrl: URL? { get {
        let urlString =  "https://5e.tools/img/bestiary/tokens/\(self.imageName.replacingOccurrences(of: " ", with: "%20")).webp"
//        debugPrint(urlString)
        
        return URL(string: urlString)
    } }
    
    func mmImageToken() -> AnyView {        
        return AnyView(
            WebImage(
                url: self.mmImageTokenUrl,
                content: { image in
                    image.resizable()
                },
                placeholder: {
                    Image(systemName: "lizard.circle")
                        .resizable()
                        .foregroundStyle(.a5EGreen)
                        .opacity(0.3)
                }
            ).onFailure { error in
//                debugPrint(error.localizedDescription)
            }
            .indicator(Indicator.progress) // SwiftUI indicator component
            .edgesIgnoringSafeArea(.all)
            .frame(width: 45, height: 45)
            .clipped()
            .transition(.fade) // Fade Transition
            .scaledToFill()
        )
    }
    
    func mmImage() -> AnyView {
        AnyView(
            WebImage(
                url: self.mmImageUrl,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit) // or .fill
                        .frame(height: 200)
                    
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
