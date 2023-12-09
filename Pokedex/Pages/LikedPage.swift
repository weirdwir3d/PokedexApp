import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    @EnvironmentObject
    var favoritesStore: FavoritesStore
    
    var body: some View {
        
        NavigationStack {
            
            if favoritesStore.isEmpty() {
                Text("No favorites have been added yet")
            } else {
                ScrollView {
                    if let pokemon = pokemonStore.pokemon {
                        switch pokemon {
                        case .success(let pokemonArray):
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 40) {
                                ForEach(pokemonArray.filter { favoritesStore.isFavorite($0) }) { singlePokemon in
                                    Card(pokemon: singlePokemon)
                                }
                            }
                            .padding()
                        case .failure(let error):
                            Text("Something went wrong: \(error.localizedDescription)")
                                .padding(16)
                            Button("Retry", action: {
                                pokemonStore.pokemon = nil
                                Task {
                                    await pokemonStore.setup()
                                }
                            })
                        }
                    } else {
                        ProgressView()
                    }
                }
                .navigationTitle("Favorite Pokemon's")
            }
            
            
        }
        .environmentObject(favoritesStore)
    }
}

#Preview {
    NavigationView {
        LikedPage()
    }
    .environmentObject(FavoritesStore())
    .environmentObject(PokemonStore())
}
