//
//  PreviewData.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//


import Foundation
import SwiftData

struct PreviewData {
    static func loadJSON<T:SwiftData.PersistentModel>(forResource resourceName: String) -> [T] where T:Decodable {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            return []
        }
    }
}
