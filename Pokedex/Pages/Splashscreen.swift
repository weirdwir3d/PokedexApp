//
//  Splashscreen.swift
//  PokedexApp721447
//
//  Created by opendag on 08/12/2023.
//

import SwiftUI

struct Splashscreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack{
                VStack{
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isActive = true
                }
            }
        }
        
        
    }
}

#Preview {
    Splashscreen()
}
