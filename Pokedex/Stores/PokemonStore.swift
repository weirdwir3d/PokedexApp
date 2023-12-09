import Foundation

@MainActor
class PokemonStore: ObservableObject {
    
    @Published var pokemon: Result<[Pokemon], Error>?
    //this does nothing
    @Published var pokemonList: [Pokemon] = []
    @Published var wantsToLoadMorePages: Bool = false
    @Published var currentPage: Int = 1
    private var isFirstSetup = true
    private var canLoadMorePages = true
    private var nextPageLink: URL?
    private var previousPageLink: URL?
    private var hasInitialSetupBeenPerformed = false
    
    
    init(pokemon: Result<[Pokemon], Error>? = nil) {
        self.pokemon = pokemon
        Task { await setup() }
    }
    
    func setWantsToLoadMorePages(_ newValue: Bool) {
        wantsToLoadMorePages = newValue
    }
}

// MARK: Data fetch
extension PokemonStore {
    
    func setup() async {
        do {
            if !canLoadMorePages && (!wantsToLoadMorePages && !isFirstSetup) {
                return
            }
            
            guard var url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
                throw PokeError.general
            }
            if wantsToLoadMorePages && canLoadMorePages && !isFirstSetup {
                guard let nextPageURL = nextPageLink else {
                    // Handle the case where nextPageLink is nil
                    throw PokeError.general
                }
                url = nextPageURL
            }
            
            let urlRequest = URLRequest(url: url, timeoutInterval: 10)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
            nextPageLink = pokemonResponse.next
            previousPageLink = pokemonResponse.previous
            if (nextPageLink == nil) {
                canLoadMorePages = false
            }
            if let nextPageURL = nextPageLink {
                let queryItems = URLComponents(url: nextPageURL, resolvingAgainstBaseURL: false)?.queryItems
                if let pageQueryItem = queryItems?.first(where: { $0.name == "page" }), let page = pageQueryItem.value, let pageNumber = Int(page) {
                    currentPage = pageNumber
                }
            }
            let newPokemon: [Pokemon] = pokemonResponse
                .results
                .compactMap { entity in
                    return Pokemon.map(from: entity)
                }
            
            pokemonList += newPokemon
            
            self.pokemon = .success(pokemonList)
        } catch {
            print("something went wrong: \(error)")
            pokemon = .failure(error)
        }
        wantsToLoadMorePages = false
        isFirstSetup = false
        
    }
}
