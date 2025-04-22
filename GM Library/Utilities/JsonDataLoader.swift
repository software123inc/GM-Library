//
//  MonsterDataLoader.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//
//  https://stackoverflow.com/questions/27965439/cannot-explicitly-specialize-a-generic-function
//  See SWIFT 5 answer

import Foundation
import SwiftData

class JsonDataLoader {
    static func loadJson<T:SwiftData.PersistentModel>(from filename: String) async -> [T] where T:Decodable {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ File not found: \(filename).json")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([T].self, from: data)
            return decodedData
        } catch {
            print("❌ Error decoding JSON: \(error)")
            return []
        }
    }
}
