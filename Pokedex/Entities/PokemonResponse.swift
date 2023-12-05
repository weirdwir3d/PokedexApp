//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import Foundation

struct PokemonResponse: Codable {
    
    let results: [PokemonEntity]
}

struct PokemonEntity: Codable {
    
    let name: String
    let url: String
}
