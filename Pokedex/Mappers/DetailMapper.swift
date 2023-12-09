import Foundation

extension PokemonDetail {
    
    
    static func map(from entity: DetailResponseEntity) -> PokemonDetail {
        return PokemonDetail(
            id: entity.id,
            types: entity.types.compactMap(PokemonDetail.mapTypes),
            baseExp: entity.base_experience,
            weight: entity.weight,
            height: entity.height,
            abilities: entity.abilities.compactMap(PokemonDetail.mapAbilities)
            
        )
    }
    
    static func mapAbilities(from entity: AbilityEntity) -> Ability {
        return Ability(name: entity.ability.name, url: entity.ability.url)
    }
    
    static func mapTypes(from entity: TypeEntity) -> PokemonType {
        return PokemonType(name: entity.type.name, url: entity.type.url)
    }
    
}
