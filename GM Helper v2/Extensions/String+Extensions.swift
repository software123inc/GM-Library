//
//  String+Extensions.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
    
    func smartCased() -> String {
        // http://www.superheronation.com/2011/08/16/words-that-should-not-be-capitalized-in-titles/
        let separator = " "
        var words = self.lowercased().components(separatedBy: separator).map({ String($0) })
        
        if words.count > 0 {
            words[0] = words[0].capitalized
            for i in 1..<words.count {
                if !["a",
                     "after",
                     "along",
                     "an",
                     "and",
                     "around",
                     "at",
                     "but",
                     "by",
                     "for",
                     "from",
                     "in",
                     "nor",
                     "of",
                     "on",
                     "or",
                     "so",
                     "the",
                     "to",
                     "with",
                     "without",
                     "yet"].contains(words[i]) {
                    words[i] = words[i].capitalized
                }
            }
        }
        return words.joined(separator: separator)
    }
}
