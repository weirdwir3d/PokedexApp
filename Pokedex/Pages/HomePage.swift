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
                // Search Bar
                SearchBar(searchText: $searchText, onSearchTextChange: { newText in
                    // Handle search text change
                    if newText.isEmpty {
                        // Clearing search text, stay on the same page
                        searchText = ""
                        Task {
                            await pokemonStore.setup()
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
                                    // Check if the last item is visible
                                    if let lastItem = filteredPokemon.last, singlePokemon.id == lastItem.id {
                                        // Fetch more data
                                        Task {
                                            pokemonStore.setWantsToLoadMorePages(true)
                                            isLoadingMore = true
                                            await pokemonStore.setup()
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
            .task { await pokemonStore.setup() }
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

struct SearchBar: View {
    @Binding var searchText: String
    var onSearchTextChange: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .foregroundColor(.primary)
                .overlay(
                    HStack {
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                onSearchTextChange(searchText)
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.primary)
                                    .padding(.trailing, 16)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                )
        }
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
