import Foundation

struct AbilityEntity: Codable {
    let ability: AbilityDetailEntity
}

struct AbilityDetailEntity: Codable {
    let name: String
    let url: String
}
