//
//  FavoritesStore.swift
//  PokedexApp721447
//
//  Created by opendag on 07/12/2023.
//

import Foundation

import SwiftUI

@MainActor
class FavoritesStore: ObservableObject {
    
    @Published var favorites: [Int] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func toggle(for pokemon: Pokemon) {
        if isFavorite(pokemon) {
            favorites.removeAll { id in
                return id == pokemon.id
            }
        } else {
            favorites.append(pokemon.id)
        }
        print("favorites: \(favorites)")
        print("is fav empty \(isEmpty())")
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        return favorites.contains(pokemon.id)
    }
    
    func isEmpty() -> Bool {
        return favorites.isEmpty
    }
    
    func getFavs() -> [Int] {
        print("favorites: \(favorites)")
        return favorites
    }

    private func saveFavorites() {
        let userDefaults = UserDefaults.standard
        do {
            let favoritesData = try JSONEncoder().encode(favorites)
            userDefaults.set(favoritesData, forKey: "favorites")
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }

    private func loadFavorites() {
        let userDefaults = UserDefaults.standard
        if let favoritesData = userDefaults.data(forKey: "favorites") {
            do {
                favorites = try JSONDecoder().decode([Int].self, from: favoritesData)
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
    }
}

