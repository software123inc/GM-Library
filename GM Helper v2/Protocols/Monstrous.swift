//
//  Monstrous.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

protocol Monstrous {
    var averageDamagePerRound: Int { get }
    var isLegendary: Bool { get }
}

extension Monstrous {
    var averageDamagePerRound: Int { 0 }
    var isLegendary: Bool { false }
}
