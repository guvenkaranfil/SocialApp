//
//  LoadingView.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        let animation = Animation
            .easeOut(duration: 1.25)
            .repeatForever(autoreverses: false)
        
        Circle()
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 0
                opacity = 1
                withAnimation(animation) {
                    scale = 1
                    opacity = 0
                }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .foregroundColor(Color("3dc6a7"))
    }
}
