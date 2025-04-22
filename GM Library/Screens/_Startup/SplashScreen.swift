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
            VStack {
                Image("GM SplashScreen Name")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.white)
                Text("Verifying Library...")
                    .foregroundStyle(.white)
                ProgressView()
                    .tint(.white)
            }
            .padding(20)
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
