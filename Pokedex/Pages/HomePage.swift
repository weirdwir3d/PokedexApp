//
//  HomePage.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import Foundation
import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    @State private var searchText = ""
    
    var body: some View {
        
        
        
        NavigationStack {
            ScrollView {
                if let pokemon = pokemonStore.pokemon {
                    switch pokemon {
                    case .success(let pokemonArray):
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 40) {
                            ForEach(pokemonArray) { singlePokemon in
                                Card(pokemon: singlePokemon)
                            }
                        }
                        .padding()
                    case .failure(let error):
                        Text("Something went wrong: \(error.localizedDescription)")
                    }
                } else {
                    ProgressView()
                }
            }
                }
                .searchable(text: $searchText)
                .navigationTitle("Pokemon List")

        
    }
}


#Preview {
    NavigationView {
        HomePage()
            .environmentObject(PokemonStore(pokemon: .success(.test)))
    }
}
