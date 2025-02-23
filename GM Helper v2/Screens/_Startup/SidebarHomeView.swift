//
//  SidebarHomeView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//
//  https://www.appcoda.com/navigationsplitview-swiftui/

/*
 The NavigationSplitViewVisibility.all value tells iPadOS to display all the three columns. There are other options including:
 .automatic – Use the default leading column visibility for the current device. This is the default setting.
 .doubleColumn – Show the content column and detail area of a three-column navigation split view.
 .detailOnly – Hide the leading two columns of a three-column split view. In other words, only the detail area shows.
 */

import SwiftUI

struct SidebarHomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var showSplash = true
    @State private var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        ZStack{
            if !showSplash {
                ThreeColumnSplitViewSectioned()
            }
            SplashScreen()
                .opacity(showSplash ? 1 : 0)
                .zIndex(showSplash ? 1 : 0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                        withAnimation() {
                            self.showSplash = false
                        }
                    }
                }
                .ignoresSafeArea(.all)
        }
    }
}

#Preview(traits: .sampleData) {
    SidebarHomeView()
}
