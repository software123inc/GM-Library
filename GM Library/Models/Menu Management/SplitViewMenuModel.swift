//
//  SplitViewMenuModel.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/19/25.
//

import Foundation
import SwiftUI
import SwiftData

struct SplitViewMenuModel: MenuItemProvider {
    let mainMenuItems = {
        let topMenuItems = [
            MenuItem(
                name: "Monsters A5e",
                image: "linea-mini"
            ),
            MenuItem(
                name: "Monsters WoTC",
                image: "linea-mini"
            ),
            MenuItem(
                name: "Spells A5e",
                image: "swift-mini"
            ),
            MenuItem(
                name: "Spells WoTC"
                , image: "swift-mini"
            ),
        ]
        
        return topMenuItems
    }()
}

class SplitViewSectionMenuModel {
    let sectionMenuItems: [SectionMenuItem] = {
        let monsterMenuItems = [
            MenuItem(
                name: "Level Up A5e",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Monster_A5e>(navigationTitle: "Monsters A5e")
                )
            ),
            MenuItem(
                name: "WoTC 2014",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Monster_WoTC>(navigationTitle: "Monsters WoTC")
                )
            ),
        ]
        
        let spellMenuItems = [
            MenuItem(
                name: "Spells A5e",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Spell_A5e>(navigationTitle: "Spells A5e")
                )
            ),
            MenuItem(
                name: "Spells WoTC",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Spell_WoTC>(navigationTitle: "Spells WoTC")
                )
            )
        ]
        
        let treasureMenuItems = [
            MenuItem(
                name: "Treasures A5e",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Treasure_A5e>(navigationTitle: "Treasures A5e")
                )
            ),
            MenuItem(
                name: "Treasures WoTC",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Treasure_WoTC>(navigationTitle: "Treasures WoTC")
                )
            )
        ]
        
        let settingsMenuItems = [
            MenuItem(
                name: "About",
                image: "linea-mini",
                subMenuItems: [
                    MenuItem(
                        name: "Licenses",
                        image: "linea-mini",
                        detailView: AnyView(LicenseView())
                        , closureView: { menuId in
                            if let menuId = menuId as? UUID {
                                return AnyView(LicenseView())
                            }
                            
                            return AnyView(LicenseView())
                        }
                    ),
                ]
            ),
        ]
        
        let sectionItems = [
            SectionMenuItem(name: "Monsters", menuItems: monsterMenuItems),
            SectionMenuItem(name: "Spells", menuItems: spellMenuItems),
            SectionMenuItem(name: "Treasures", menuItems: treasureMenuItems),
            SectionMenuItem(name: "", menuItems: settingsMenuItems),
        ]
        
        return sectionItems
    }()
    
    
    func menuItem(for id:MenuItem.ID) -> MenuItem? {
        // Merge all menuItems into a single array.
        // https://stackoverflow.com/questions/24465281/flatten-an-array-of-arrays-in-swift
        let menuItems = sectionMenuItems.compactMap( { $0.menuItems }).reduce([],+)
        
        guard let menuItem = menuItems.first(where: { $0.id == id }) else {
            return nil
        }
        
        return menuItem
    }
}
