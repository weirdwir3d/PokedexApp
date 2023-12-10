import Foundation
import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    @State private var searchText = ""
    
    @State private var isRefreshing = false
    @State private var isLoadingMore = false
    
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
            VStack {
                SearchBar(searchText: $searchText, onSearchTextChange: { newText in
                    if newText.isEmpty {
                        searchText = ""
                        Task {
                            await pokemonStore.fetchMorePokemon()
                        }
                    }
                })
                .padding()
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                // Pokemon Grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 40) {
                        ForEach(filteredPokemon) { singlePokemon in
                            Card(pokemon: singlePokemon)
                                .onAppear {
                                    if let lastItem = filteredPokemon.last, singlePokemon.id == lastItem.id {
                                        // Fetch more data
                                        Task {
                                            pokemonStore.setWantsToLoadMorePages(true)
                                            isLoadingMore = true
                                            await pokemonStore.fetchMorePokemon()
                                            isLoadingMore = false
                                        }
                                    }
                                }
                        }
                    }
                    .padding()
                    .overlay(
                        isLoadingMore ? ProgressView()
                            .padding(.vertical, 10) : nil,
                        alignment: .bottom
                    )
                }
            }
            .task { await pokemonStore.fetchMorePokemon() }
            .navigationTitle("Home")
        }
        .refreshable {
            isRefreshing = true
            pokemonStore.pokemon = nil
            await pokemonStore.setup()
            isRefreshing = false
        }
        .overlay(
            RefreshControl(isRefreshing: $isRefreshing)
        )
    }
    
}

struct RefreshControl: View {
    @Binding var isRefreshing: Bool
    
    var body: some View {
        if isRefreshing {
            ProgressView()
                .padding(.vertical, 10)
        } else {
            EmptyView()
        }
    }
}



#Preview {
    NavigationView {
        HomePage()
            .environmentObject(PokemonStore(pokemon: .success(.test)))
    }
}
