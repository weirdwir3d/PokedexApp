import Foundation
import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    //    @StateObject
    //    var favoritesStore = FavoritesStore()
    
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
            if let pokemonArray = try? pokemonStore.pokemon?.get() {
                if searchText.isEmpty {
                    return pokemonArray
                } else {
                    return pokemonArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
            }
            return []
        }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                if let pokemon = pokemonStore.pokemon {
                    switch pokemon {
                    case .success(let pokemonArray):
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 40) {
                                                ForEach(filteredPokemon) { singlePokemon in
                                                    Card(pokemon: singlePokemon)
                                                }
                                            }
                        .padding()
                    case .failure(let error):
                        VStack {
                            Text("Something went wrong: \(error.localizedDescription)")
                                .padding()
                            Button("Retry", action: {
                                pokemonStore.pokemon = nil
                                Task {
                                    await pokemonStore.setup()
                                }
                            })
                        }
                        
                    }
                } else {
                    ProgressView()
                }
            }
            .task { await pokemonStore.setup() }
            .navigationTitle("Home")
        }
        .searchable(text: $searchText)
        //                .environmentObject(favoritesStore)
        
    }
}


#Preview {
    NavigationView {
        HomePage()
            .environmentObject(PokemonStore(pokemon: .success(.test)))
    }
}
