//
//  DamageHelper.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import Foundation

class DamageHelper {
    static let shared = DamageHelper()
    
    /// Extract damage values from attack text
    static func parseDamage(from text: String) -> Int {
        let regex = try? NSRegularExpression(pattern: "\\d+d\\d+\\s?\\+?\\s?\\d*", options: [])
        let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count)) ?? []
        return matches.reduce(0) { total, match in
            let matchText = (text as NSString).substring(with: match.range)
            return total + averageDiceDamage(matchText)
        }
    }
    
    /// Calculates the expected value of a dice roll
    static func averageDiceDamage(_ diceNotation: String) -> Int {
        let components = diceNotation.components(separatedBy: "d")
        if components.count == 2, let numDice = Int(components[0]), let dieType = Int(components[1]) {
            return numDice * (dieType + 1) / 2
        }
        return 0
    }
}
