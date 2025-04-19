//
//  MenuItem.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
import SwiftUI
import SwiftData

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var subMenuItems: [MenuItem]?
//    var manObjType: (any SwiftData.PersistentModel.Type)?
    var contentView: AnyView? = nil
    var detailView: AnyView? = nil    
    var closureView: ((_ menuId: Any) -> AnyView)? // change to optional closure
    var contentViewAlt: (any View)? = nil
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(image)
        hasher.combine(subMenuItems)
    }
}

protocol MenuItemProvider {
    var mainMenuItems: [MenuItem] { get }
    
    func subMenuItems(for id: MenuItem.ID) -> [MenuItem]?
    func menuItem(for categoryID: MenuItem.ID, itemID: MenuItem.ID) -> MenuItem?
    func menuItem(for id: MenuItem.ID) -> MenuItem?
}

extension MenuItemProvider {
    func subMenuItems(for id: MenuItem.ID) -> [MenuItem]? {
        guard let menuItem = mainMenuItems.first(where: { $0.id == id }) else {
            return nil
        }
        
        return menuItem.subMenuItems
    }
    
    func menuItem(for categoryID: MenuItem.ID, itemID: MenuItem.ID) -> MenuItem? {
        guard let subMenuItems = subMenuItems(for: categoryID) else {
            return nil
        }
        
        guard let menuItem = subMenuItems.first(where: { $0.id == itemID }) else {
            return nil
        }
        
        return menuItem
    }
    
    func menuItem(for id: MenuItem.ID) -> MenuItem? {
        guard let menuItem = mainMenuItems.first(where: { $0.id == id }) else {
            return nil
        }
        
        return menuItem
    }
}


