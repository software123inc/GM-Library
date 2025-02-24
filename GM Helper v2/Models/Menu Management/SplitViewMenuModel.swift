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
        let monsterA5eSubMenuItems = [ MenuItem(name: "M1 Advanced 5e", image: "swift"),
                                       MenuItem(name: "M2 Advanced 5e", image: "vulcano")
        ]
        
        let monsterWotcSubMenuItems = [ MenuItem(name: "WoTC 2 Monster", image: "swift"),
                                        MenuItem(name: "WoTC 2 Monster", image: "vulcano")
        ]
        
        let spellsMenuItems = [ MenuItem(name: "Spell 1", image: "swift"),
                                MenuItem(name: "Spell 2", image: "vulcano")
        ]
        
        let topMenuItems = [
            MenuItem(
                name: "Monsters A5e",
                image: "linea-mini"
//                contentView: AnyView(MonsterA5eListView())
            ),
            MenuItem(
                name: "Monsters WoTC",
                image: "linea-mini"
//                contentView: AnyView(MonsterWotcListView())
            ),
            MenuItem(name: "Spells A5e", image: "swift-mini", subMenuItems: spellsMenuItems),
            MenuItem(name: "Spells WoTC", image: "swift-mini", subMenuItems: spellsMenuItems),
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
            MenuItem(
                name: "Normalized",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Monster>(navigationTitle: "Monsters")
                )
                
            )
        ]
        
        let spellMenuItems = [
            MenuItem(
                name: "Spells A5e",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Spell_Ae5>(
                        navigationTitle: "Spells A5e"
                    )
                )
            ),
            MenuItem(
                name: "Spells WoTC",
                image: "linea-mini",
                contentView: AnyView(
                    PersistentModelListView<Spell_WoTC>(
                        navigationTitle: "Spells WoTC"
                    )
                )
            )
        ]
        
        let settingsMenuItems = [
            MenuItem(
                name: "Settings",
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
