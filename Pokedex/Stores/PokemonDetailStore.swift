//
//  PokemonDetailStore.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import Foundation

@MainActor
class PokemonDetailStore: ObservableObject {
    
    @Published
    var details: Result<PokemonDetail, Error>?
    
    func fetchDetails(for pokemon: Pokemon) async {
        // TODO: Implement
    }
}
