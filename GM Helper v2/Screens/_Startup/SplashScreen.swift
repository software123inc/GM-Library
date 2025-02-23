//
//  SplashScreen.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/18/25.
//

import SwiftUI

struct SplashScreen: View {
    let launchScreenBackground = Color("launchScreenBackground", bundle: nil)
    
    var body: some View {
        ZStack {
            Text("GM Helper")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(launchScreenBackground)
    }
}

struct SplashScreen_Previews : PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
