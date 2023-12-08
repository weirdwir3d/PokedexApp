//
//  FavoritesStore.swift
//  PokedexApp721447
//
//  Created by opendag on 07/12/2023.
//

import Foundation

@MainActor
class FavoritesStore: ObservableObject {
    
    @Published var favorites: [Int] = []
    
    func toggle(for pokemon: Pokemon) {
        print("running func toggle")
        if isFavorite(pokemon) {
            favorites.removeAll { id in
                return id == pokemon.id
            }
        } else {
            favorites.append(pokemon.id)
        }
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        print("running func isFav")
        return favorites.contains(pokemon.id)
    }
}

//extension FavoritesStore {
    
//    func toggle(for pokemon: Pokemon) {
//        print("running func toggle")
//        if isFavorite(pokemon) {
//            favorites.removeAll { id in
//                return id == pokemon.id
//            }
//        } else {
//            favorites.append(pokemon.id)
//        }
//    }
//    
//    func isFavorite(_ pokemon: Pokemon) -> Bool {
//        print("running func isFav")
//        return favorites.contains(pokemon.id)
//    }
//}