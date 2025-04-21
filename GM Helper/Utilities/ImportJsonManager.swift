//
//  ImportJsonManager.swift
//  GM Helper
//
//  Created by Tim W. Newton on 4/19/25.
//

import Foundation
import SwiftData

@MainActor
struct ImportJsonManager {
    let modelContext:ModelContext
    
    init(mainContext: ModelContext) {
        self.modelContext = mainContext
    }
    
    func importJsonData() {
        if isEntityEmpty(Monster_A5e.self) {
            importMonstersA5e()
        }
        
        if isEntityEmpty(Monster_WoTC.self) {
            importMonstersWoTC()
        }
        
        if isEntityEmpty(Spell_A5e.self) {
            importSpellsA5e()
        }
        
        if isEntityEmpty(Spell_WoTC.self) {
            importSpellsWoTC()
        }
        
        if isEntityEmpty(Treasure_A5e.self) {
            importTreasuresA5e()
        }
        
        if isEntityEmpty(Treasure_WoTC.self) {
            importTreasuresWoTC()
        }
    }
    
    // <T:SwiftData.PersistentModel>(value: T.Type
    private func isEntityEmpty<T:SwiftData.PersistentModel>(_ entity: T.Type) -> Bool {
        let descriptor = FetchDescriptor<T>()
        do {
            let objs = try modelContext.fetch(descriptor)
            print("\(entity) count: \(objs.count)")
            return objs.isEmpty
        } catch {
            print("Error checking entity: \(error)")
            return false
        }
    }
    
    func importMonstersA5e() {
        if SyncManager.shared.importMonstersA5e {
            Task {
                await asyncImportJson(
                    entity:Monster_A5e.self,
                    resource: JsonResourceKey.monstersA5e.rawValue,
                    &SyncManager.shared.importMonstersA5e
                )
                
                insertNormalizedMonsters(entity: Monster_A5e.self)
                saveDefaultData("Monster_A5e");
            }
        }
    }
    
    func importMonstersWoTC() {
        if SyncManager.shared.importMonstersWoTC {
            Task {
                await asyncImportJson(
                    entity:Monster_WoTC.self,
                    resource: JsonResourceKey.monstersWoTC.rawValue,
                    &SyncManager.shared.importMonstersWoTC
                )
                
                insertNormalizedMonsters(entity: Monster_WoTC.self)
                saveDefaultData("Monster_WoTC");
            }
        }
    }
    
    func importSpellsA5e() {
        if SyncManager.shared.importSpellsA5e {
            Task {
                await asyncImportJson(
                    entity:Spell_A5e.self,
                    resource: JsonResourceKey.spellsA5e.rawValue,
                    &SyncManager.shared.importSpellsA5e
                )
                
                insertNormalizeSpells(entity: Spell_A5e.self)
                saveDefaultData("Spell_A5e");
            }
        }
    }
    
    func importSpellsWoTC() {
        if SyncManager.shared.importSpellsWoTC {
            Task {
                await asyncImportJson(
                    entity:Spell_WoTC.self,
                    resource: JsonResourceKey.spellsWoTC.rawValue,
                    &SyncManager.shared.importSpellsWoTC
                )
                
                insertNormalizeSpells(entity: Spell_WoTC.self)
                saveDefaultData("Spell_WoTC");
            }
        }
    }
    
    func importTreasuresA5e() {
        if SyncManager.shared.importTreasuresA5e {
            Task {
                await asyncImportJson(
                    entity:Treasure_A5e.self,
                    resource: JsonResourceKey.treasuresA5e.rawValue,
                    &SyncManager.shared.importTreasuresA5e
                )
            }
            
            insertNormalizeTreasures(entity: Treasure_A5e.self)
            saveDefaultData("Treasure_A5e");
        }
    }
    
    func importTreasuresWoTC() {
        if SyncManager.shared.importTreasuresWoTC {
            Task {
                await asyncImportJson(
                    entity:Treasure_WoTC.self,
                    resource: JsonResourceKey.treasuresWoTC.rawValue,
                    &SyncManager.shared.importTreasuresWoTC
                )
            }
            
            insertNormalizeTreasures(entity: Treasure_WoTC.self)
            saveDefaultData("Treasure_WoTC");
        }
    }
    
    private func asyncImportJson<T:SwiftData.PersistentModel>(entity: T.Type, resource:String, _ status: inout Bool) async where T:Decodable {
        debugPrint("Importing from '\(resource)'.")
        let items = await JsonDataLoader.loadJson(from: resource) as [T]
        
        do {
            for item in items {
                modelContext.insert(item)
            }
            
            try modelContext.save()
        } catch {
            debugPrint("[ERROR: \(entity)] \(error.localizedDescription)")
        }
        
        status.toggle()
    }
    
    private func insertNormalizedMonsters<T:SwiftData.PersistentModel>(entity: T.Type) where T:MonstrousDTO, T:Nameable {
        let fetcher = FetchDescriptor<T>(sortBy: [.init(\T.name)])
        if let monsters = try? modelContext.fetch(fetcher) {
            for monster in monsters {
                var m:Monster?
                switch T.self {
                    case is Monster_A5e.Type:
                        let mm = monster as! Monster_A5e
                        m = monster.toMonster(monsterA5e: mm)
                    case is Monster_WoTC.Type:
                        let mm = monster as! Monster_WoTC
                        m = monster.toMonster(monsterWoTC: mm)
                    default:
                        debugPrint("Unhandled normalized monster type: \(T.self)")
                        break
                        
                }
                if let m {
                    modelContext.insert(m)
                }
            }
        }
    }
    
    private func insertNormalizeSpells<T:SwiftData.PersistentModel>(entity: T.Type) where T:SpellDTO, T:Nameable {
        let fetcher = FetchDescriptor<T>(sortBy: [.init(\T.name)])
        if let results = try? modelContext.fetch(fetcher) {
            for result in results {
                var target:Spell?
                switch T.self {
                    case is Spell_A5e.Type:
                        let item = result as! Spell_A5e
                        target = result.toSpell(spellA5e: item)
                    case is Spell_WoTC.Type:
                        let item = result as! Spell_WoTC
                        target = result.toSpell(spellWoTC: item)
                    default:
                        debugPrint("Unhandled normalized spell type: \(T.self)")
                        break
                        
                }
                if let target {
                    modelContext.insert(target)
                }
            }
            
            //            debugPrint("Saved normalized spells from: \(T.self), count: \(results.count)")
        }
    }
    
    private func insertNormalizeTreasures<T:SwiftData.PersistentModel>(entity: T.Type) where T:TreasureDTO, T:Nameable {
        let fetcher = FetchDescriptor<T>(sortBy: [.init(\T.name)])
        if let results = try? modelContext.fetch(fetcher) {
            for result in results {
                var target:Treasure?
                switch T.self {
                    case is Treasure_A5e.Type:
                        let item = result as! Treasure_A5e
                        target = result.toTreasure(treasureA5e: item)
                    case is Treasure_WoTC.Type:
                        let item = result as! Treasure_WoTC
                        target = result.toTreasure(treasureWoTC: item)
                    default:
                        debugPrint("Unhandled normalized treasure type: \(T.self)")
                        break
                        
                }
                if let target {
                    modelContext.insert(target)
                }
            }
            
            //            debugPrint("Saved normalized spells from: \(T.self), count: \(results.count)")
        }
    }
    
    private func saveDefaultData(_ entity: String = "[all]") {
        do {
            debugPrint("Doing Save: \(entity)")
            try modelContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
