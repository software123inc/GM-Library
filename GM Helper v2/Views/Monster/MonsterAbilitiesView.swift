//
//  MonsterAbilitiesView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct MonsterAbilitiesView: View {
    var monster: Monster
    
    var body: some View {
        if let ability = monster.abilities {
            HStack {
                ScoreView(name: "STR", value: ability.str)
                ScoreView(name: "DEX", value: ability.dex)
                ScoreView(name: "CON", value: ability.con)
                ScoreView(name: "INT", value: ability.int)
                ScoreView(name: "WIS", value: ability.wis)
                ScoreView(name: "CHA", value: ability.cha)
            }
            A5eHorizontalBorderView()
        }
    }
    
    struct ScoreView: View {
        let name:String
        let value:Int
        
        var body: some View {
            VStack {
                Text(name.localizedUppercase).fontWeight(.bold)
                Text(String(value))
                Text(rollModifier(value: value))
            }
            .frame(maxWidth: .infinity)
        }
        
        func rollModifier(value:Int) -> String {
            let modifier = (value - 10) / 2
            var sign = ""
            
            if modifier < 0 {
                sign = "-"
            }
            else if modifier > 0 {
                sign = "+"
            }
            
            return "(\(sign + String(modifier)))"
        }
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        MonsterAbilitiesView(monster: (PreviewData
            .loadJSON(
                forResource: JsonResourceKey.monstersA5e.rawValue
            ).first! as Monster_A5e).toMonster()
        )
    }
}
