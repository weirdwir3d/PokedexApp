//
//  ContentView.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var pokemonStore = PokemonStore()
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            LikedPage()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        .environmentObject(pokemonStore)
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PokemonStore())
}
