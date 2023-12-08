import Foundation

struct PokemonDetail: Identifiable {
    let id: Int
    var types: [PokemonType]
    var baseExp: Int
    var weight: Int
    var height: Int
    var abilities: [Ability]
    var imageUrl: URL{
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")!
    }
}
