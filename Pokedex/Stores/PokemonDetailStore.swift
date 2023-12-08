import Foundation

@MainActor
class PokemonDetailStore: ObservableObject {
    
    @Published
    var details: Result<PokemonDetail, Error>?
    
    func fetchDetails(for pokemon: Pokemon) async {
        do {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)") else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 10000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(DetailResponseEntity.self, from: data)
            let pokemonDetailResponse: DetailResponseEntity = pokemonResponse
            var pokemonDetails: PokemonDetail = PokemonDetail.map(from: pokemonDetailResponse)
            self.details = .success(pokemonDetails)
            print("pokemonResponse \(pokemonResponse)")
            
        } catch {
            print("something went wrong in the DetailsStore: \(error)")
            details = .failure(error)
            
        }
    }
    
}
