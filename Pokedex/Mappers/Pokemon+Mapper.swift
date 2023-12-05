//
//  Pokemon+Mapper.swift
//  Pokedex
//
//  Created by Kevin van den Hoek on 13/10/2023.
//

import Foundation

extension Pokemon {
    
    static func map(from entity: PokemonEntity) -> Pokemon? {
        guard let idString = entity.url.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        return Pokemon(
            id: id,
            name: entity.name.capitalized
        )
    }
}
