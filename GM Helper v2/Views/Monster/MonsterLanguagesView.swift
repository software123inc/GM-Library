//
//  MonsterLanguagesView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI

struct MonsterLanguagesView: View {
    var monster: Monster
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Languages").fontWeight(.bold)
            Text(monster.languages)
            Spacer()
        }
    }
}

struct MonsterXPView: View {
    var monster: Monster
    
    var formatter = {
        var ff = NumberFormatter()
        ff.numberStyle = .decimal
        ff.locale = Locale.current
        
        return ff
    }()
    
    var body: some View {
        if let xp = monster.xp {
            HStack(alignment: .top) {
                Text("Challenge").fontWeight(.bold)
                Text("\(monster.challengeText) (\(formatter.string(from: NSNumber(value: xp)) ?? "0") XP)")
                Spacer()
            }
        }
        else {
            EmptyView()
        }
    }
}
