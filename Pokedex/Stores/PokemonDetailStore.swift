import Foundation

@MainActor
class PokemonDetailStore: ObservableObject {
    
    @Published
    var details: Result<DetailResponse, Error>?
    
    func fetchDetails(for pokemon: Pokemon) async {
        do {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)") else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 2500)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(DetailResponse.self, from: data)
            let pokemon: DetailResponse = pokemonResponse
            self.details = .success(pokemon)
            
        } catch {
            print("something went wrong in the DetailsStore: \(error)")
            details = .failure(error)
        }
    }
    
}
