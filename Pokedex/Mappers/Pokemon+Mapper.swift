import Foundation

extension Pokemon {
    
    static func map(from entity: PokemonEntity) -> Pokemon? {
        guard let idString = entity.url.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        return Pokemon(
            id: id,
            name: entity.name.capitalized
        )
    }
}
