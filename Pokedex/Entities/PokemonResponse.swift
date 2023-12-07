import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonEntity]
}

struct PokemonEntity: Codable {
    
    let name: String
    let url: String
}
