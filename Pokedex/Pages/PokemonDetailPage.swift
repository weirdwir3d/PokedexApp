//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import Foundation
import SwiftUI

struct PokemonDetailPage: View {
    
    let pokemon: Pokemon
    
    @StateObject
    var detailStore = PokemonDetailStore()
    
    var body: some View {
        VStack {
            Text(pokemon.name)
            if let details = detailStore.details {
                switch details {
                case .success(let details):
                    Color.green // TODO: Implement
                case .failure(let error):
                    Color.red // TODO: Implement
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await detailStore.fetchDetails(for: pokemon)
        }
    }
}

#Preview {
    PokemonDetailPage(pokemon: .test)
}
