//
//  KeyEnums.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/17/25.
//


import Foundation

enum AppStorageKey: String {
    case importMonstersA5e
    case importSpellsA5e
    case importMonstersWoTC
    case importSpellsWoTC
    case importTreasuresA5e
    case importTreasuresWoTC
}

enum JsonResourceKey: String {
    case monstersA5e = "Level Up Advanced 5e Monsters"
    case monstersWoTC = "WoTC SRD 5e Monsters"
    case spellsA5e = "Level Up Advanced 5e Spells"
    case spellsWoTC = "WoTC SRD 5e Spells"
    case treasuresA5e = "Level Up Advanced 5e Treasures"
    case treasuresWoTC = "WoTC SRD 5e Treasures"
}

enum EnvironmentKey: String {
    case xcodePreviewMode = "XCODE_RUNNING_FOR_PREVIEWS"
}

enum SourceKey: String {
    case a5e = "A5e"
    case wotc = "WoTC"
    case homebrew = "Homebrew"
}
