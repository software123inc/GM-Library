//
//  MonsterActionsView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/26/25.
//

import SwiftUI

struct MonsterActionsView: View {
    @State private var isExpanded = true
    var monster: Monster
    
    var body: some View {
        MonsterAnyActionsView(title: "ACTIONS", someActions: monster.actions)
    }
}

struct MonsterBonusActionsView: View {
    @State private var isExpanded = true
    var monster: Monster
    
    var body: some View {
        let someActions = monster.bonusActions
        
        if !someActions.isEmpty {
            MonsterAnyActionsView(title: "BONUS ACTIONS", someActions: someActions)
        } else {
            EmptyView()
        }
    }
}

struct MonsterReactionsView: View {
    @State private var isExpanded = true
    var monster: Monster
    
    var body: some View {
        let someActions = monster.reactions
        if !someActions.isEmpty {
            MonsterAnyActionsView(title: "REACTIONS", someActions:someActions)
        } else {
            EmptyView()
        }
    }
}

struct MonsterLegendaryActionsView: View {
    @State private var isExpanded = true
    var monster: Monster
    
    var body: some View {
        let someActions = monster.legendaryActions
        if !someActions.isEmpty {
            MonsterAnyActionsView(title: "LEGENDARY ACTIONS", someActions:someActions)
        } else {
            EmptyView()
        }
    }
}

struct MonsterMythicActionsView: View {
    @State private var isExpanded = true
    var monster: Monster
    
    var body: some View {
        let someActions = monster.mythicActions
        if !someActions.isEmpty {
            MonsterAnyActionsView(title: "MYTHIC ACTIONS", someActions:someActions)
        } else {
            EmptyView()
        }
    }
}

struct MonsterAnyActionsView: View {
    @State private var isExpanded = true
    let title: String
    var someActions: [ActionTrait]
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(someActions.sorted(by: { lhs, rhs -> Bool in lhs.name < rhs.name})) { row in
                    row.detailView()
                }
            }
        }
        label: {
            VStack(spacing: 0) {
                A5eHorizontalBorderView()
                HStack {
                    Text(title.localizedUppercase)
                        .foregroundStyle(.a5EGreen)
                    Spacer()
                }
                .background(Color.tanned)
            }
        }
    }
}
