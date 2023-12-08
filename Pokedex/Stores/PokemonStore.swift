import Foundation

@MainActor
class PokemonStore: ObservableObject {
    
    @Published var pokemon: Result<[Pokemon], Error>?
    
    init(pokemon: Result<[Pokemon], Error>? = nil) {
        self.pokemon = pokemon
        Task { await setup() }
    }
}

// MARK: Data fetch
extension PokemonStore {
    
    func setup() async {
        do {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 10)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
            let pokemon: [Pokemon] = pokemonResponse
                .results
                .compactMap { entity in
                    return Pokemon.map(from: entity)
                }
            self.pokemon = .success(pokemon)
        } catch {
            print("something went wrong: \(error)")
            pokemon = .failure(error)
        }
    }
}
